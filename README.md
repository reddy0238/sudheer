# personality-assessment
## Personality Assessment using Natural Language Processing features

###### Execution:
	1. python readjson.py <input_file>
	   ex: python readjson.py users/aamirkhan.json

###### Additional Instructions:
	To scrape Twitter data, NodeJS scripts are used.
	To download new user data, please install NodeJS and run gettweets.js file.
	Please change screen name query parameter in line 10 API call to the user name you wish to download.

	ex: node gettweets.js > aamirkhan

	The data extracted from Twitter API is not a perfect JSON and 
	cannot be inputted to python script directly.
	Please install hanson npm module.

	> npm install hanson

	and run

	> hanson aamirkhan aamirkhan.json

###### Third-Party Packages Used:
	1. NLTK
	2. python-levenshtein
	3. gensim
	4. pyemd

###### Note:
	1. All the method calls for the feature implemention is commented.
       Please uncomment the feature method call which you wish to run.

    2. Semantic feature (count_synonyms) method runtime is exponential.
