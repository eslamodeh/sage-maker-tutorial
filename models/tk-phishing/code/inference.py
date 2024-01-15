
# https://github.com/mobassir94/Deploy-trained-TensorFlow-2.x-models-using-Amazon-SageMaker/blob/main/inference.py
# https://docs.aws.amazon.com/sagemaker/latest/dg/neo-deployment-hosting-services-prerequisites.html

import json
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


# rest of the inference script from here

def input_handler(data, context):
    """ Pre-process request input before it is sent to TensorFlow Serving REST API
    Args:
        data (obj): the request data, in format of dict or string
        context (Context): an object containing request and configuration details
    Returns:
        (dict): a JSON-serializable dict that contains request body and headers
    """
    if context.request_content_type == 'application/json':
        payload = data.read().decode('utf-8')
        logger.info("From input handler {}".format(json.dumps(payload)))

        # pass through json (assumes it's correctly formed)
        d = data.read().decode('utf-8')
        return d if len(d) else ''

    raise ValueError("Wrong input format given {}. Allowed format application/json").format(
        context.request_content_type or "unknown")


def output_handler(data, context):
    logger.info("From output handler: {}".format(json.dumps(data)))

    """Post-process TensorFlow Serving output before it is returned to the client.
    Args:
        data (obj): the TensorFlow serving response
        context (Context): an object containing request and configuration details
    Returns:
        (bytes, string): data to return to client, response content type
    """
    if data.status_code != 200:
        raise ValueError(data.content.decode('utf-8'))

    response_content_type = context.accept_header
    prediction = data.content
    return prediction, response_content_type