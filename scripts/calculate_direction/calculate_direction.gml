function calculate_direction()
{
	panoramaaspectratio = min(max(panoramaaspectratio, 0.1), 6)
	MaximumVerticalAngle = atand2((700 / panoramaaspectratio) / 2, 100) - 30
	zdirection = min(max(zdirection, -MaximumVerticalAngle), MaximumVerticalAngle)
	mousex = round((2 - (direction / 360 + 1)) * ImageWidth mod ImageWidth)
	mousey = round(((1 - (z + (tand(zdirection) * 100) / (700 / panoramaaspectratio))) * ImageHeight) - (ImageHeight / 2))
}
