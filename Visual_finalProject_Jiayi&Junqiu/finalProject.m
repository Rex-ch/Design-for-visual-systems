% Initialize the face detector, point tracker, and webcam
faceDetector = vision.CascadeObjectDetector();
pointTracker = vision.PointTracker('MaxBidirectionalError', 1);
cam = webcam();

% Capture one frame to determine video size
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);

% Load and prepare the overlay image
Monkey = imread('IMG_0502.PNG');
if ndims(Monkey) == 2  % If Monkey is grayscale
    Monkey = repmat(Monkey, 1, 1, 3);  % Replicate the grayscale image across 3 channels
end

runLoop = true;
numPts = 0;
frameCount = 0;

while runLoop && frameCount < 4000
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;

    if numPts < 20
        bbox = faceDetector.step(videoFrameGray);
        if ~isempty(bbox)
            biggestBox = sortrows(bbox, -3); % Sort by box width in descending order
            bbox = biggestBox(1, :); % Use the largest detected face

            points = detectMinEigenFeatures(videoFrameGray, 'ROI', bbox);
            xyPoints = points.Location;
            numPts = size(xyPoints, 1);
            release(pointTracker);
            initialize(pointTracker, xyPoints, videoFrameGray);
            oldPoints = xyPoints;

            bboxPolygon = reshape(bbox2points(bbox(1, :))', 1, []);
        end
    else
        [xyPoints, isFound] = step(pointTracker, videoFrameGray);
        visiblePoints = xyPoints(isFound, :);
        oldInliers = oldPoints(isFound, :);

        numPts = size(visiblePoints, 1);
        if numPts >= 20
            [xform, inlierIdx] = estimateGeometricTransform2D(oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
            oldInliers = oldInliers(inlierIdx, :);
            visiblePoints = visiblePoints(inlierIdx, :);

            % Apply the transformation to get the new bounding box points and compute the bounding box
            bboxPointsTransformed = transformPointsForward(xform, bbox2points(bbox(1, :)));
            minX = min(bboxPointsTransformed(:,1));
            minY = min(bboxPointsTransformed(:,2));
            maxX = max(bboxPointsTransformed(:,1));
            maxY = max(bboxPointsTransformed(:,2));
            bbox = [minX, minY, maxX-minX, maxY-minY];

            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);
        end
    end

    if ~isempty(bbox)
        % Resize and overlay the Monkey image based on the current bbox
        bboxWidth = round(bbox(3));
        bboxHeight = round(bbox(4));
        resizedMonkey = imresize(Monkey, [bboxHeight, bboxWidth]);

        for x = 1:bboxWidth
            for y = 1:bboxHeight
        % Calculate the coordinates in videoFrame
            px = round(x + bbox(1)) - 1;
            py = round(y + bbox(2)) - 1;
        
        % Check if the calculated coordinates are within videoFrame bounds
            if px >= 1 && py >= 1 && px <= size(videoFrame, 2) && py <= size(videoFrame, 1)
            % Overlay the non-transparent pixel from resizedMonkey onto videoFrame
                if resizedMonkey(y, x, 1) ~= 0 || resizedMonkey(y, x, 2) ~= 0 || resizedMonkey(y, x, 3) ~= 0
                videoFrame(py, px, :) = resizedMonkey(y, x, :);
                end
            end
            end
        end
    end

    % Display the annotated video frame using the video player object
    step(videoPlayer, videoFrame);

    % Check whether the video player window has been closed
    runLoop = isOpen(videoPlayer);
end

% Cleanup
clear cam;
release(videoPlayer);
release(pointTracker);
