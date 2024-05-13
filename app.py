from flask import request, Flask

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
    image = request.files["image"]
    ext = image.filename.split(".")[-1]
    filename = f"download_temp.{ext}"
    image.save(filename)
    
    result = img_captioning(filename)
    
    return result[OutputKeys.CAPTION]
