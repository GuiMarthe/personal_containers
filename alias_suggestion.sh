docker run -ti -e AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id) -e AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key) -v $(pwd):/home/athena athenacli_conteiner athenacli