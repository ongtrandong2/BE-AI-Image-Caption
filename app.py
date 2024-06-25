# try:
#     import crcmod
#     import flask
#     import modelscope
#     import fairseq
#     import cv2
#     import timm
#     import ftfy
#     import tensorboardX
#     import pycocotools
#     import pytorch_lightning
#     import einops
#     import datasets
#     import rouge_score
#     import soundfile
#     import editdistance
#     import librosa
#     import Levenshtein
#     import zhconv
#     import pypinyin
#     import protobuf
#     import transformers
#     import unicodedata2
#     import decord
#     print("All modules imported successfully!")
# except ImportError as e:
#     print(f"Error importing module: {e}")

# from flask import request, Flask

# from modelscope.pipelines import pipeline
# from modelscope.utils.constant import Tasks
# from modelscope.outputs import OutputKeys

# app = Flask(__name__)

# img_captioning = pipeline(Tasks.image_captioning, model='damo/ofa_image-caption_coco_distilled_en', model_revision='v1.0.1')

# @app.route("/", methods=["GET", "POST"])
# def home():
#     return "Home"


# @app.route("/predict", methods=["POST"])
# def predict():
#     image = request.files["image"]
#     ext = image.filename.split(".")[-1]
#     filename = f"download_temp.{ext}"
#     image.save(filename)
    
#     result = img_captioning(filename)
    
#     return result[OutputKeys.CAPTION]
try:
    import crcmod
    import flask
    import modelscope
    import fairseq
    import cv2
    import timm
    import ftfy
    import tensorboardX
    import pycocotools
    import pytorch_lightning
    import einops
    import datasets
    import rouge_score
    import soundfile
    import editdistance
    import librosa
    import Levenshtein
    import zhconv
    import pypinyin
    import google.protobuf  # import correctly
    import transformers
    import unicodedata2
    import decord
    print("All modules imported successfully!")
except ImportError as e:
    print(f"Error importing module: {e}")

from flask import request, Flask, jsonify
from modelscope.pipelines import pipeline
from modelscope.utils.constant import Tasks
from modelscope.outputs import OutputKeys

app = Flask(__name__)

img_captioning = pipeline(Tasks.image_captioning, model='damo/ofa_image-caption_coco_distilled_en', model_revision='v1.0.1')

@app.route("/", methods=["GET", "POST"])
def home():
    return "Home"

@app.route("/predict", methods=["POST"])
def predict():
    try:
        image = request.files["image"]
        ext = image.filename.split(".")[-1]
        filename = f"download_temp.{ext}"
        image.save(filename)
        
        result = img_captioning(filename)
        caption = result[OutputKeys.CAPTION]
        
        return jsonify({"caption": caption})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
