FROM tensorflow/serving

# Installing NGINX, used to rever proxy the predictions from SageMaker to TF Serving
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends nginx git

# Copy our model folder to the container
COPY models/tk-phishing/ /saved_model_phishing_v1

# Copy NGINX configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

# starts NGINX and TF serving pointing to our model
ENTRYPOINT service nginx start | tensorflow_model_server --rest_api_port=8501 \
 --model_name=phishing \
 --model_base_path=/saved_model_phishing_v1/model/phishing
