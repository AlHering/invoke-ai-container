#!/bin/bash

source /invoke-ai-container/venv/bin/activate
cd /invoke-ai-container/invoke-ai
python -m pip install "InvokeAI[xformers]" --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu117
invokeai-configure -c invokeai.yaml --skip-support-models --skip-sd-weights -y
