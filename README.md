# Assessment-For-Ideaslab

for the question iOS to iOS video transmission

1. How should the two iOS devices connect with each other?  (e.g., Bluetooth)
	
    1. Bluetooth: The two devices can use Bluetooth to create a peer-to-peer connection and transfer data between them. You can use the CoreBluetooth framework in iOS to create a Bluetooth connection between the devices.
    2. Wi-Fi: The two devices can connect to the same Wi-Fi network and transfer data between them using IP addresses. You can use the Network framework in iOS to create a Wi-Fi connection between the devices.
    3. Near Field Communication (NFC): If both devices have NFC support, you can use NFC to establish a connection between them, and transfer data over it.
    4. Cloud: You can also use cloud services such as Firebase, AWS, or Azure to share data between the devices. The devices can connect to the cloud service, upload data, and download data from the cloud service.
    5. Multipeer Connectivity: You can use the framework MultipeerConnectivity which allows the devices to discover other devices nearby, and establish a direct connection between them.
		The best method of connection depends on the requirement of the app and the range of the devices. For example, if the devices need to be within close proximity to each other, Bluetooth or NFC would be a good choice. If the devices are going to be in different locations, a cloud service would be a better choice.
		It's worth noting that when it comes to video streaming and live video streaming, using a cloud service would be the best option due to the nature of video data, the size of it and the need for low latency.
	


2. How can we determine which one is the master/host(iPad) and slave(iPhone)
	There are several ways to determine which device is the master (iPad) and which is the slave (iPhone) when connecting two iOS devices:

    1. User Input: You can ask the user to specify which device is the master and which is the slave. This can be done by displaying a message on both devices asking the user to choose a role.
    2. Automatic Detection: You can use the device's unique identifier, such as the UDID, to determine which device is the master and which is the slave. For example, you can hardcode the UDID of the iPad as the master device in the app and automatically detect it when the devices are connecting.
    3. Device Capabilities: You can use the capabilities of the devices to determine which one is the master and which one is the slave. For example, if the device has a camera, it can be considered as the slave device, while the device without a camera can be considered as the master device.
    4. Role Negotiation: You can have a role negotiation process between the devices, in which they exchange information about their capabilities, and based on that information, one device can be selected as the master and the other as the slave.
    5. First Connected: You can also use the time of connection to decide the role of the devices. The device that connects first can be considered as the master and the other as the slave.
	
	It's worth noting that the method that you choose to determine the roles of the devices depends on the requirement of the app, and it can be a combination of the above methods.
	Once the master and slave device have been determined, you should establish a connection between them, and the master device should be responsible for coordinating the data transfer between the two devices.





3. Define a protocol that interfaces function between the communication of the iOS devices.  For instance, start/stop commands will be sent from iPhone to iPad. Would you happen to know if we need to send video size/dimensions information?  Please write down any communication/information needed to be exchanged between devices.  How do we detect if the transmission is getting slower?  Is bidirectional communication needed?  If so, how is it implemented?
		
		1. protocol DeviceCommunicationProtocol {
		    func startStreaming()
		    func stopStreaming()
		    func setVideoSize(width: Int, height: Int)
		    func sendVideoBuffer(buffer: Data)
		    func connectionEstablished()
		    func connectionLost()
		    func updateTransmissionSpeed(speed: Double)
		}

		• startStreaming() and stopStreaming(): These functions can be used to start and stop the streaming of video from the iPhone to the iPad. The iPhone can use these functions to notify the iPad to start or stop receiving video data.
        * setVideoSize(width: Int, height: Int) : This function can be used to notify the iPad about the video size and dimensions. It's necessary to know the video size and dimensions to display the video correctly on the iPad.
        * sendVideoBuffer(buffer: Data) : This function can be used to send the video buffer to the iPad.
        * connectionEstablished() and connectionLost(): These functions can be used to notify the iPad that a connection has been established with the iPhone or that the connection has been lost.
        * updateTransmissionSpeed(speed: Double): This function can be used to notify the iPad about the current transmission speed. The iPad can use this information to detect if the transmission is getting slower.

		Bidirectional communication is needed in this scenario, the iPad should be able to send the start/stop commands to the iPhone and also the iPhone should be able to send the video buffer and the video size information to the iPad.

		To implement bidirectional communication, you can use a library such as Socket.IO-Client-Swift or Alamofire to handle the network communication between the devices, and use the above-defined protocol functions to handle the data exchange between the devices.

		You can also use the MultipeerConnectivity framework in iOS to handle the network communication between the devices.

		You can also implement some kind of error handling mechanism like retransmission of data, sending acknowledgement signal, etc to make sure that the data is being transmitted correctly and the transmission is not getting slower.

		In short, the communication protocol should cover the following aspects:
            * Start and stop streaming command
            * Video size and dimension information
            * Video buffer transmission
            * Connection establishment and lost
            * Transmission speed monitoring
            * Error handling mechanism
            * Bidirectional communication mechanism



4. All videos should be seen in the correct orientation, not 90 degrees to the right/left or upside down.  iPhone cameras do not capture by default right side up.  How should this be handled both on the iPhone (if it is flipped from portrait to landscape), how should the video be transferred (with orientation?), and should the iPhone and/or iPad be responsible for correcting orientation?

		Handling video orientation correctly can be a bit tricky, but here's one way to handle it:
            1. On the iPhone:
                * The iPhone can use the AVCaptureVideoPreviewLayer to capture the video in the correct orientation. You can use the connection.videoOrientation property of the AVCaptureConnection class to set the video orientation to match the device's orientation.
                * You can also use the UIDevice class to detect when the device orientation changes, and adjust the video orientation accordingly.
                * After capturing the video, you can use the AVAssetExportSession class to rotate the video if it's not in the correct orientation, then you can send the video buffer to the iPad.
            2. On the iPad:
                * The iPad can use the AVPlayer class to play the video. You can use the AVPlayerLayer class to display the video on the screen.
                * You can also use the AVAsset class to read the video's metadata and check the video's orientation. Then you can use the AVMutableVideoComposition to rotate the video if it's not in the correct orientation.
			
		It's worth noting that, to keep the video quality high, it's recommended to rotate the video on the device that captures it. Also, to keep the latency low, the video orientation should be corrected on the device that displays it.
		
		Also, it's good practice to include the video orientation in the metadata of the video buffer that is sent to the iPad. This way, the iPad can use this information to display the video in the correct orientation

5. In the future, there may be 4 iPhone camera feeds going to the iPad. What do we need to consider, and what interface functions in our protocol do we need to implement to support this?

		If in the future you need to support multiple iPhone camera feeds going to the iPad, here are a few things to consider:
            1. Network bandwidth: Each additional camera feed will require more network bandwidth to transmit the video data. You'll need to make sure that the network connection between the devices is fast enough to handle the additional data.
            2. Latency: The more cameras you have, the more data you'll need to transmit, and the higher the latency will be. You'll need to make sure that the latency is low enough to provide a good user experience.
            3. UI design: You'll need to consider how to display the multiple camera feeds on the iPad's screen. You can use a grid view, a split-screen view, or a gallery view to display the video feeds.
            4. Video Synchronization: With multiple cameras, it's crucial to have the videos synced to avoid any confusion or latency. The iPad should be able to receive the video from multiple cameras and display them in the correct order.
            5. Camera Selection: The iPad should have the capability to select which cameras' feeds to show, also it should be able to switch between them.
		To support multiple camera feeds in the protocol, you'll need to implement the following interface functions:
            * startStreaming(cameraId: Int): This function can be used to start the streaming of video from a specific iPhone camera to the iPad.
            * stopStreaming(cameraId: Int): This function can be used to stop the streaming of video from a specific iPhone camera to the iPad.
            * setVideoSize(width: Int, height: Int, cameraId: Int): This function can be used to notify the iPad about the video size and dimensions of a specific camera.
            * sendVideoBuffer(buffer: Data, cameraId: Int): This function can be used to send the video buffer of a specific camera to the iPad.
            * switchCamera(cameraId: Int): This function can be used to switch between the cameras' feeds on the iPad.

		It's worth noting that you will also need to implement a mechanism to keep track of the connected cameras and their statuses, so the iPad can know which cameras are available and which are not. Also, you will need to handle the case when a new camera connected or disconnected, and notify the iPad accordingly.




