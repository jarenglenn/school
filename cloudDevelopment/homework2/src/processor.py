from abc import ABC, abstractmethod
import json

class Processor(ABC):
    def process(self, request):
        request_content = json.loads(request.get()["Body"].read())
        request.delete()

        print(f"Processing a {request_content['type'].upper()} request")

        if request_content["type"] == "create":
            self._process_create(request_content)

        elif request_content["type"] == "update":
            self._process_update(request_content)

        elif request_content["type"] == "delete":
            self._process_delete(request_content)

    @abstractmethod
    def _process_create(self, request):
        pass

    @abstractmethod
    def _process_update(self, request):
        pass

    @abstractmethod
    def _process_delete(self, request):
        pass


class S3Processor(Processor):
    def __init__(self, response_bucket) -> None:
        self.response_bucket = response_bucket

    def _process_create(self, request):
        owner = request["owner"].replace(" ", "-").lower()
        self.response_bucket.put_object(
            Key=f"widgets/{owner}/{request['widgetId']}",
            Body=json.dumps(request),
        )

    def _process_update(self, request):
        pass

    def _process_delete(self, request):
        pass

class DynamoDBProcessor(Processor):
    def __init__(self, response_table) -> None:
        self.response_table = response_table

    def _process_create(self, request):
        self.response_table.put_item(
            Item={
                "id": request["widgetId"],
                "owner": request["owner"],
                "label": request["label"],
                "description": request["description"],
                **{a["name"]: a["value"] for a in request["otherAttributes"]},
            }
        )

    def _process_update(self, request):
        pass

    def _process_delete(self, request):
        pass