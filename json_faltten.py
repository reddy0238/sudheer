'''
In Snowflake Snowpark (Python 3.11) I have a DataFrame whose column value is either a VARIANT or a JSON-string. I want a single function

python
Copy
Edit
def flatten_json_snowpark(df: DataFrame, json_col: str) -> DataFrame
that in one pass:

Parses json_col into a VARIANT (if it isn’t one already).

Recursively unwraps every OBJECT into <parent>_<child> columns.

Flattens every ARRAY (using Snowpark’s flatten() table function) so elements become individual rows.

Repeats until no nested OBJECT or ARRAY remains.

The result should be a DataFrame of only primitive columns—one per leaf JSON field—plus whatever other original columns you passed in. Please provide the simplest working Snowpark Python code.
'''

'''
pyspark logic 
'''
from pyspark.sql.functions import col, from_json, md5
from pyspark.sql.types import StructType, ArrayType

def _flatten_iter(df):
    while True:
        fld = next(
            (f for f in df.schema.fields
             if isinstance(f.dataType, (StructType, ArrayType))),
            None
        )
        if fld is None:
            break

        name, dtype = fld.name, fld.dataType

        if isinstance(dtype, StructType):
            # unpack struct → top‐level cols, then drop it
            expanded = [
                col(f"{name}.{sub.name}").alias(f"{name}_{sub.name}")
                for sub in dtype.fields
            ]
            df = df.select("*", *expanded).drop(name)

        else:  # ArrayType
            tmp = f"{name}__exploded"
            df = (
                df
                .withColumn(tmp, explode_outer(col(name)))
                .drop(name)
                .withColumnRenamed(tmp, name)
            )

    return df

def flatten_json(df, json_col):
    #md5 hash 
    df = df.withColumn("hashid", md5(col(json_col)))

    # 1) parse JSON into a temp struct col
    jschema = spark.read.json(
        df.select(json_col).rdd.map(lambda r: r[json_col])
    ).schema

    df2 = df.withColumn("_tmp_struct", from_json(col(json_col), jschema))

    # 2) splice all tmp_struct.* fields out, drop the tmp column
    df2 = df2.select("*", "_tmp_struct.*").drop("_tmp_struct")

    # 3) now flatten everything else
    return _flatten_iter(df2)
'''
snowpark
'''
from snowflake.snowpark.functions import (
    col, parse_json, flatten as sp_flatten, object_keys
)
from snowflake.snowpark.types import StructType, ArrayType, VariantType

def _flatten_iter_snowpark(df):
    while True:
        # find the first complex field (ARRAY or VARIANT/OBJECT)
        fld = next(
            (f for f in df.schema.fields
             if isinstance(f.datatype, (ArrayType, VariantType))),
            None
        )
        if fld is None:
            break

        name = fld.name
        dtype = fld.datatype

        if isinstance(dtype, ArrayType):
            # explode the array into rows, then keep only the VALUE column
            exploded = sp_flatten(col(name)).alias(f"{name}_f")
            df = (
                df
                .join(exploded, how="left")                         # adds KEY, INDEX, VALUE
                .with_column(name, col(f"{name}_f").get("VALUE"))   # extract the element
                .drop(name + "_f")                                   # drop the temp struct
            )

        else:  # VariantType holding an OBJECT
            # first collect all object-keys (one pass per batch)
            keys = df.select(object_keys(col(name))).first()[0]
            # for each key, pull it out as its own column
            for k in keys:
                df = df.with_column(f"{name}_{k}", col(name).get(k))
            df = df.drop(name)

    return df

def flatten_json_snowpark(df, json_col):
    """
    :param df:    Snowpark DataFrame with a VARIANT or string column (json_col)
    :param json_col: name of the column to treat as JSON
    """
    # 1) if it’s a string, parse into VARIANT; if already VARIANT, this is a no-op
    df2 = df.with_column(json_col,
        parse_json(col(json_col)).cast("VARIANT")
    )

    # 2) kick off the iterative flatten
    return _flatten_iter_snowpark(df2)
