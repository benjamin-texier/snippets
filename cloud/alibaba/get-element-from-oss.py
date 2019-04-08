#!/usr/bin/python
import oss2
auth = oss2.Auth ('LTAIaKXHDLob34PW', 'y6uzwJz29FBY9VURRPlXVgxPMK28iU')
bucket = oss2.Bucket (auth, 'YOUREndpoint', 'YOURBucket_name')
bucket.put_object_from_file('remote.txt', 'labex.txt')   
bucket.get_object_to_file('remote.txt', 'local-backup.txt')