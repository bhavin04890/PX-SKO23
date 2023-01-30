#!/bin/sh
aws iam create-user --user-name workshop
aws iam create-access-key --user-name workshop > workshop-creds.txt
AWS_ID=$(aws sts get-caller-identity --query Account --output text)
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --user-name workshop


sleep 20
aws iam create-policy --policy-name pxec2node --policy-document file://pxec2policy > iampolicyoutput.txt

