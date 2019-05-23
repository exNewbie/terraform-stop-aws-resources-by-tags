# terraform-stop-aws-resources-by-tags
Stop AWS resources queried by tags

## Bundle the latest version of boto3
```
cd ./modules/scripts
virtualenv -p python3.6 venv
source venv/bin/activate
pip install -r requirements.txt
deactivate
```
