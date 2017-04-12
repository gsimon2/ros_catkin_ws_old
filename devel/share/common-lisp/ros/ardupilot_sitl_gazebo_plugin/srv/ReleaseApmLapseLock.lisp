; Auto-generated. Do not edit!


(cl:in-package ardupilot_sitl_gazebo_plugin-srv)


;//! \htmlinclude ReleaseApmLapseLock-request.msg.html

(cl:defclass <ReleaseApmLapseLock-request> (roslisp-msg-protocol:ros-message)
  ((process_id
    :reader process_id
    :initarg :process_id
    :type cl:string
    :initform ""))
)

(cl:defclass ReleaseApmLapseLock-request (<ReleaseApmLapseLock-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ReleaseApmLapseLock-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ReleaseApmLapseLock-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ardupilot_sitl_gazebo_plugin-srv:<ReleaseApmLapseLock-request> is deprecated: use ardupilot_sitl_gazebo_plugin-srv:ReleaseApmLapseLock-request instead.")))

(cl:ensure-generic-function 'process_id-val :lambda-list '(m))
(cl:defmethod process_id-val ((m <ReleaseApmLapseLock-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ardupilot_sitl_gazebo_plugin-srv:process_id-val is deprecated.  Use ardupilot_sitl_gazebo_plugin-srv:process_id instead.")
  (process_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ReleaseApmLapseLock-request>) ostream)
  "Serializes a message object of type '<ReleaseApmLapseLock-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'process_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'process_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ReleaseApmLapseLock-request>) istream)
  "Deserializes a message object of type '<ReleaseApmLapseLock-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'process_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'process_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ReleaseApmLapseLock-request>)))
  "Returns string type for a service object of type '<ReleaseApmLapseLock-request>"
  "ardupilot_sitl_gazebo_plugin/ReleaseApmLapseLockRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ReleaseApmLapseLock-request)))
  "Returns string type for a service object of type 'ReleaseApmLapseLock-request"
  "ardupilot_sitl_gazebo_plugin/ReleaseApmLapseLockRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ReleaseApmLapseLock-request>)))
  "Returns md5sum for a message object of type '<ReleaseApmLapseLock-request>"
  "c05d882edd165bc15552be77c9967c82")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ReleaseApmLapseLock-request)))
  "Returns md5sum for a message object of type 'ReleaseApmLapseLock-request"
  "c05d882edd165bc15552be77c9967c82")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ReleaseApmLapseLock-request>)))
  "Returns full string definition for message of type '<ReleaseApmLapseLock-request>"
  (cl:format cl:nil "string process_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ReleaseApmLapseLock-request)))
  "Returns full string definition for message of type 'ReleaseApmLapseLock-request"
  (cl:format cl:nil "string process_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ReleaseApmLapseLock-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'process_id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ReleaseApmLapseLock-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ReleaseApmLapseLock-request
    (cl:cons ':process_id (process_id msg))
))
;//! \htmlinclude ReleaseApmLapseLock-response.msg.html

(cl:defclass <ReleaseApmLapseLock-response> (roslisp-msg-protocol:ros-message)
  ((nb_holders
    :reader nb_holders
    :initarg :nb_holders
    :type cl:integer
    :initform 0))
)

(cl:defclass ReleaseApmLapseLock-response (<ReleaseApmLapseLock-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ReleaseApmLapseLock-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ReleaseApmLapseLock-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ardupilot_sitl_gazebo_plugin-srv:<ReleaseApmLapseLock-response> is deprecated: use ardupilot_sitl_gazebo_plugin-srv:ReleaseApmLapseLock-response instead.")))

(cl:ensure-generic-function 'nb_holders-val :lambda-list '(m))
(cl:defmethod nb_holders-val ((m <ReleaseApmLapseLock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ardupilot_sitl_gazebo_plugin-srv:nb_holders-val is deprecated.  Use ardupilot_sitl_gazebo_plugin-srv:nb_holders instead.")
  (nb_holders m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ReleaseApmLapseLock-response>) ostream)
  "Serializes a message object of type '<ReleaseApmLapseLock-response>"
  (cl:let* ((signed (cl:slot-value msg 'nb_holders)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ReleaseApmLapseLock-response>) istream)
  "Deserializes a message object of type '<ReleaseApmLapseLock-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nb_holders) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ReleaseApmLapseLock-response>)))
  "Returns string type for a service object of type '<ReleaseApmLapseLock-response>"
  "ardupilot_sitl_gazebo_plugin/ReleaseApmLapseLockResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ReleaseApmLapseLock-response)))
  "Returns string type for a service object of type 'ReleaseApmLapseLock-response"
  "ardupilot_sitl_gazebo_plugin/ReleaseApmLapseLockResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ReleaseApmLapseLock-response>)))
  "Returns md5sum for a message object of type '<ReleaseApmLapseLock-response>"
  "c05d882edd165bc15552be77c9967c82")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ReleaseApmLapseLock-response)))
  "Returns md5sum for a message object of type 'ReleaseApmLapseLock-response"
  "c05d882edd165bc15552be77c9967c82")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ReleaseApmLapseLock-response>)))
  "Returns full string definition for message of type '<ReleaseApmLapseLock-response>"
  (cl:format cl:nil "int32 nb_holders~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ReleaseApmLapseLock-response)))
  "Returns full string definition for message of type 'ReleaseApmLapseLock-response"
  (cl:format cl:nil "int32 nb_holders~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ReleaseApmLapseLock-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ReleaseApmLapseLock-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ReleaseApmLapseLock-response
    (cl:cons ':nb_holders (nb_holders msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ReleaseApmLapseLock)))
  'ReleaseApmLapseLock-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ReleaseApmLapseLock)))
  'ReleaseApmLapseLock-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ReleaseApmLapseLock)))
  "Returns string type for a service object of type '<ReleaseApmLapseLock>"
  "ardupilot_sitl_gazebo_plugin/ReleaseApmLapseLock")