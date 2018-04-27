all: spark 
push: push-spark 
.PHONY: push push-spark spark

# To bump the Spark version, bump the spark_ver in Dockerfile, bump
# this tag and reset to v1. You should also double check the native
# Hadoop libs at that point (we grab the 2.6.1 libs, which are
# appropriate for 1.5.2-with-2.6). Note that you'll need to re-test
# Zeppelin (and it may not have caught up to newest Spark).
TAG = 2.2.1_v1
REPO = casassg

spark:
	docker build -t $(REPO)/spark .
	docker tag $(REPO)/spark $(REPO)/spark:$(TAG)


push-spark: spark
	docker push $(REPO)/spark
	docker push $(REPO)/spark:$(TAG)

clean:
	docker rmi $(REPO)/spark:$(TAG) || :
	docker rmi $(REPO)/spark || :
