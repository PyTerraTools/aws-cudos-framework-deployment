import os

import boto3
from aws_lambda_powertools import Logger
from botocore.config import Config

account_id = os.environ["QUICKSIGHT_ACCOUNT_ID"]

logger = Logger()
quicksight_client = boto3.client(
    "quicksight", config=Config(connect_timeout=5, read_timeout=5)
)


def lambda_handler(event, context):
    """
    Entry point for the AWS Lambda function.
    """
    logger.info("Lambda handler started")
    try:
        # Extract user ARN from the event
        user_arn = event["detail"]["serviceEventDetails"]["eventResponseDetails"][
            "userId"
        ]
        update_quicksight_dataset_permissions(user_arn)
    except Exception as e:
        logger.exception(f"Exception in lambda_handler: {e}")
    logger.info("Lambda handler finished")


def list_quicksight_data_sets():
    """
    Retrieve the list of data sets in the QuickSight account
    """
    try:
        logger.info("Retrieving the list of data sets in the QuickSight account")

        response = quicksight_client.list_data_sets(
            AwsAccountId=account_id,
        )

        quicksight_data_sets = [
            dataset["DataSetId"] for dataset in response["DataSetSummaries"]
        ]

    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)
    return quicksight_data_sets


def update_quicksight_dataset_permissions(user_arn):
    """
    Update the permissions for the QuickSight data sets for a specific user
    """
    try:
        logger.info(
            "Updating the permissions for the Quicksight data sets for user: "
            + user_arn
        )

        dataset_list = list_quicksight_data_sets()

        for dataset in dataset_list:
            response = quicksight_client.update_data_set_permissions(
                AwsAccountId=account_id,
                DataSetId=dataset,
                GrantPermissions=[
                    {
                        "Principal": user_arn,
                        "Actions": [
                            "quicksight:DescribeDataSet",
                            "quicksight:DescribeDataSetPermissions",
                            "quicksight:PassDataSet",
                            "quicksight:DescribeIngestion",
                            "quicksight:ListIngestions",
                        ],
                    },
                ],
            )
            logger.info(
                f"Updated permissions for dataset {dataset} for user {user_arn}: {response}"
            )
    except Exception as general_error:
        logger.error(f"An unexpected error occurred: {general_error}", exc_info=True)
