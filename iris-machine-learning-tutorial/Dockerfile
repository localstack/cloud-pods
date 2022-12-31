FROM public.ecr.aws/lambda/python:3.8

RUN pip3 install numpy pandas sklearn

COPY ./lambda_function.py ./

CMD [ "lambda_function.lambda_handler" ]
