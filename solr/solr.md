## Installing solr on macOS
```shell
$ brew install solr
$ solr -version
7.7.1
```

## 基本概念 
### コレクション
インデックスを作って検索するドキュメント集合の単位。
### シャード数
- コレクションの論理的なパーティションで、ドキュメントのインデックス作成時にどのシャードに属するのかが決められる。
- クエリは各シャードにルーティングしてそれぞれで検索される。
### レプリカ数
- レプリカはシャードごとに設定し、各シャードは1つ以上のレプリカを持つ。
- レプリカの1つはleaderに指名され、leaderはインデックスの更新を他のreplicaに伝搬する。

### Starting solr running in SolrCloud mode
```shell
$ which solr
/usr/local/bin/solr
$ solr start -e cloud
```
- Running two nodes using 8983 and 7574 ports
- two shards
- two replicas per shard
- When SolrCloud example running, visit http://localhost:8983/solr

### Other commands
- Removing existing collection
```shell
$ solr delete -c [collection]
```
- Stoping all services
```shell
$ solr stop -all
```
- Createing new collection 'techproducts'
```
http://localhost:8983/solr/admin/collection?
action=CREATE&name=techproducts&numShards=2&replicationFactor=2&
maxShardsPerNode=2&collection.configName=techproducts
```
## Indexing and searching using exampledocs
### Indexing
At first, we can make indexes using exampledocs
```shell
$ cd /usr/local/Cellar/solr/7.7.1
$ bin/post -c techproducts example/exampledocs/*
...omitted...
SimplePostTool version 5.0.0
Posting files to [base] url http://localhost:8983/solr/techproducts/update...
Entering auto mode. File endings considered are xml,json,jsonl,csv,pdf,doc,docx,ppt,pptx,xls,xlsx,odt,odp,ods,ott,otp,ots,rtf,htm,html,txt,log
POSTing file books.csv (text/csv) to [base]
POSTing file books.json (application/json) to [base]/json/docs
POSTing file gb18030-example.xml (application/xml) to [base]
POSTing file hd.xml (application/xml) to [base]
POSTing file ipod_other.xml (application/xml) to [base]
POSTing file ipod_video.xml (application/xml) to [base]
POSTing file manufacturers.xml (application/xml) to [base]
POSTing file mem.xml (application/xml) to [base]
POSTing file money.xml (application/xml) to [base]
POSTing file monitor.xml (application/xml) to [base]
POSTing file monitor2.xml (application/xml) to [base]
POSTing file more_books.jsonl (application/json) to [base]/json/docs
POSTing file mp500.xml (application/xml) to [base]
POSTing file post.jar (application/octet-stream) to [base]/extract
POSTing file sample.html (text/html) to [base]/extract
POSTing file sd500.xml (application/xml) to [base]
POSTing file solr-word.pdf (application/pdf) to [base]/extract
POSTing file solr.xml (application/xml) to [base]
POSTing file test_utf8.sh (application/octet-stream) to [base]/extract
POSTing file utf8-example.xml (application/xml) to [base]
POSTing file vidcard.xml (application/xml) to [base]
21 files indexed.
COMMITting Solr index changes to http://localhost:8983/solr/techproducts/update...
Time spent: 0:00:43.292
```
The exampledocs have been indexed and we can start to search.

### Searching
Now we can try the following 5 types of search:
- Basic searching
	- Via Solr Admin UI
	` http://localhost:8983/solr/#/techproducts/query`
	- Via curl
	`curl "http://localhost:8983/solr/techproducts/select?indent=on&q=*:*"`
- Search for a Single Term
Just like this:
```shell
$ curl "http://localhost:8983/solr/techproducts/select?q=foundation"
{
  "responseHeader":{
    "zkConnected":true,
    "status":0,
    "QTime":651,
    "params":{
      "q":"foundation"}},
  "response":{"numFound":4,"start":0,"maxScore":2.6861532,"docs":[
      {
        "id":"0553293354",
        "cat":["book"],
        "name":"Foundation",
        "price":7.99,
        "price_c":"7.99,USD",
        "inStock":true,
        "author":"Isaac Asimov",
        "author_s":"Isaac Asimov",
        "series_t":"Foundation Novels",
        "sequence_i":1,
        "genre_s":"scifi",
        "_version_":1628664318309433344,
        "price_c____l_ns":799},
      {
        "id":"UTF8TEST",
        "name":"Test with some UTF-8 encoded characters",
	...omitted..}]
}
```
As another usage, we can put "id" (without quotes) to the "fl" field so as to 
matching return records only contain id fields.
```shell
$ curl "http://localhost:8983/solr/techproducts/select?q=foundation&fl=id"
{
  "responseHeader":{
    "zkConnected":true,
    "status":0,
    "QTime":446,
    "params":{
      "q":"foundation",
      "fl":"id"}},
  "response":{"numFound":4,"start":0,"maxScore":2.6861532,"docs":[
      {
        "id":"0553293354"},
      {
        "id":"UTF8TEST"},
      {
        "id":"SOLR1000"},
      {
        "id":"/usr/local/Cellar/solr/7.7.1/example/exampledocs/test_utf8.sh"}]
  }}
```
- Field Searches
For example, we can limit the our search for only documents with the category "electronics",
the results will be more precise for our users.
`curl "http://localhost:8983/solr/techproducts/select?q=cat:electronics"`
- Phrase Search
To search for a multi-term phrase, enclose it in double quotes: q="multiple terms here". 
If we’re using curl, note that the space between terms must be converted to "+" in a URL, as so:
`curl "http://localhost:8983/solr/techproducts/select?q=\"CAS+latency\""`
- Combining Searches


## Getting contents from my blogs and saving them to local files
- Writing a python srcipt named getContents.py as below
```shell
import urllib.request
import os.path
import time

urls = [
    'http://blog.livedoor.jp/gxliu/archives/278227.html',
    'http://blog.livedoor.jp/gxliu/archives/312679.html',
    'http://blog.livedoor.jp/gxliu/archives/613538.html',
    'http://blog.livedoor.jp/gxliu/archives/767863.html',
    'http://blog.livedoor.jp/gxliu/archives/776386.html',
    'http://blog.livedoor.jp/gxliu/archives/1003197.html',
    'http://blog.livedoor.jp/gxliu/archives/1012986.html',
    'http://blog.livedoor.jp/gxliu/archives/1152128.html',
    'http://blog.livedoor.jp/gxliu/archives/1244051.html',
    'http://blog.livedoor.jp/gxliu/archives/1436671.html',
    'http://blog.livedoor.jp/gxliu/archives/1454963.html',
    'http://blog.livedoor.jp/gxliu/archives/1475006.html',
    'http://blog.livedoor.jp/gxliu/archives/1577126.html',
    'http://blog.livedoor.jp/gxliu/archives/1583854.html',
    'http://blog.livedoor.jp/gxliu/archives/1756964.html',
    'http://blog.livedoor.jp/gxliu/archives/1757080.html',
    'http://blog.livedoor.jp/gxliu/archives/1877291.html',
    'http://blog.livedoor.jp/gxliu/archives/2049060.html'
]

dir = '/tmp/solr/documents'
for url in urls:
	filename = os.path.basename(url)
	urllib.request.urlretrieve(url, dir + '/' + filename)
	time.sleep(1) 

exit(0)
```
- The files downloaded are below
```shell
$ ls /tmp/solr/downloads
1003197.html  1436671.html  1583854.html  2049060.html  767863.html
1012986.html  1454963.html  1756964.html  278227.html   776386.html
1152128.html  1475006.html  1757080.html  312679.html
1244051.html  1577126.html  1877291.html  613538.html
```
## Making indexes for the contents
```shell
$ which post
/usr/local/bin/post
$ /usr/local/bin/post -c gettingstarted /tmp/solr/documents/*
...omitted...
```
- So far, the preparation for searching is completed

## Searching
- Query
`http://localhost:8983/solr/gettingstarted/select?q=*:*`
- For example, let's search using empty query
```json
{
  "responseHeader":{
    "zkConnected":true,
    "status":0,
    "QTime":235,
    "params":{
      "q":"*:*"}},
  "response":{"numFound":0,"start":0,"maxScore":0.0,"docs":[]
  }}
```
