import boto3


def list_buckets():
    s3 = boto3.resource("s3")
    for bucket in s3.buckets.all():
        print(bucket.name)


if __name__ == "__main__":
    list_buckets()
