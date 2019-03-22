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
