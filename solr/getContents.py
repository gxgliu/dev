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
