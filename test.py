from PIL import Image
from matplotlib import image as mpimg
from matplotlib import pyplot as plt
from modelscope.pipelines import pipeline
from modelscope.utils.constant import Tasks
from modelscope.outputs import OutputKeys

img_captioning = pipeline(
    Tasks.image_captioning, model='damo/ofa_image-caption_coco_distilled_en', model_revision='v1.0.1')
result = img_captioning(
    'C:/Users/ACER/Desktop/Anh/anhthe.jpg')
# 'a bunch of donuts on a wooden board with popsicle sticks'
print(result[OutputKeys.CAPTION])
# 目前caption支持了batch inference，方式非常简单，具体如下：
# result = img_captioning(
#     [{'image': 'C:/Users/ACER/Desktop/Anh/download.jpg'} for _ in range(1)], batch_size=2)
# for r in result:
#     print(r[OutputKeys.CAPTION])


# plt.title(result[OutputKeys.CAPTION])

# image = mpimg.imread('C:/Users/ACER/Desktop/Anh/download.jpg')
# plt.imshow(image)
# plt.show()

img = Image.open('C:/Users/ACER/Desktop/Anh/anhthe.jpg')
img.show()
