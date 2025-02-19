default: add-video-dev

track-face:
	pipenv run python src/uses/track_face.py

crop-cam:
	pipenv run python src/uses/entry.py crop-cam

# create a virtual video device on Linux
add-video-dev:
	# sudo fuser /dev/video10 # to find out what is using the device
	pkill gst-launch &> /dev/null || true
	rmmod v4l2loopback &> /dev/null || true
	modprobe v4l2loopback devices=1 max_buffers=2 exclusive_caps=1 video_nr=10 card_label="v4l-cam"

# setup-webcam: add-video-dev
# 	v4l2loopback-ctl set-caps 'video/x-raw,format=I420,width=320,height=240' /dev/video10

# describe video devices on Linux
.PHONY: describe-devices
describe-devices:
	v4l2-ctl --list-device
	v4l2-ctl --list-formats-ext
