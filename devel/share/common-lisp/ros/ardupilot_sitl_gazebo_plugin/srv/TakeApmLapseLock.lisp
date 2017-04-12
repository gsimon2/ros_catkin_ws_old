; Auto-generated. Do not edit!


(cl:in-package ardupilot_sitl_gazebo_plugin-srv)


;//! \htmlinclude TakeApmLapseLock-request.msg.html

(cl:defclass <TakeApmLapseLock-request> (roslisp-msg-protocol:ros-message)
  ((process_id
    :reader process_id
    :initarg :process_id
    :type cl:string
    :initform "")
   (max_duration
    :reader max_duration
    :initarg :max_duration
    :type cl:float
    :initform 0.0))
)

(cl:defclass TakeApmLapseLock-request (<TakeApmLapseLock-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TakeApmLapseLock-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TakeApmLapseLock-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ardupilot_sitl_gazebo_plugin-srv:<TakeApmLapseLock-request> is deprecated: use ardupilot_sitl_gazebo_plugin-srv:TakeApmLapseLock-request instead.")))

(cl:ensure-generic-function 'process_id-val :lambda-list '(m))
(cl:defmethod process_id-val ((m <TakeApmLapseLock-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ardupilot_sitl_gazebo_plugin-srv:process_id-val is deprecated.  Use ardupilot_sitl_gazebo_plugin-srv:process_id instead.")
  (process_id m))

(cl:ensure-generic-function 'max_duration-val :lambda-list '(m))
(cl:defmethod max_duration-val ((m <TakeApmLapseLock-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ardupilot_sitl_gazebo_plugin-srv:max_duration-val is deprecated.  Use ardupilot_sitl_gazebo_plugin-srv:max_duration instead.")
  (max_duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TakeApmLapseLock-request>) ostream)
  "Serializes a message object of type '<TakeApmLapseLock-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'process_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'process_id))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'max_duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TakeApmLapseLock-request>) istream)
  "Deserializes a message object of type '<TakeApmLapseLock-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'process_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'process_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_duration) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TakeApmLapseLock-request>)))
  "Returns string type for a service object of type '<TakeApmLapseLock-request>"
  "ardupilot_sitl_gazebo_plugin/TakeApmLapseLockRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TakeApmLapseLock-request)))
  "Returns string type for a service object of type 'TakeApmLapseLock-request"
  "ardupilot_sitl_gazebo_plugin/TakeApmLapseLockRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TakeApmLapseLock-request>)))
  "Returns md5sum for a message object of type '<TakeApmLapseLock-request>"
  "88fb6d40bf2b0fa731238774f37356ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TakeApmLapseLock-request)))
  "Returns md5sum for a message object of type 'TakeApmLapseLock-request"
  "88fb6d40bf2b0fa731238774f37356ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TakeApmLapseLock-request>)))
  "Returns full string definition for message of type '<TakeApmLapseLock-request>"
  (cl:format cl:nil "string process_id~%float32 max_duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TakeApmLapseLock-request)))
  "Returns full string definition for message of type 'TakeApmLapseLock-request"
  (cl:format cl:nil "string process_id~%float32 max_duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TakeApmLapseLock-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'process_id))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TakeApmLapseLock-request>))
  "Converts a ROS message object to a list"
  (cl:list 'TakeApmLapseLock-request
    (cl:cons ':process_id (process_id msg))
    (cl:cons ':max_duration (max_duration msg))
))
;//! \htmlinclude TakeApmLapseLock-response.msg.html

(cl:defclass <TakeApmLapseLock-response> (roslisp-msg-protocol:ros-message)
  ((nb_holders
    :reader nb_holders
    :initarg :nb_holders
    :type cl:integer
    :initform 0))
)

(cl:defclass TakeApmLapseLock-response (<TakeApmLapseLock-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TakeApmLapseLock-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TakeApmLapseLock-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ardupilot_sitl_gazebo_plugin-srv:<TakeApmLapseLock-response> is deprecated: use ardupilot_sitl_gazebo_plugin-srv:TakeApmLapseLock-response instead.")))

(cl:ensure-generic-function 'nb_holders-val :lambda-list '(m))
(cl:defmethod nb_holders-val ((m <TakeApmLapseLock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ardupilot_sitl_gazebo_plugin-srv:nb_holders-val is deprecated.  Use ardupilot_sitl_gazebo_plugin-srv:nb_holders instead.")
  (nb_holders m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TakeApmLapseLock-response>) ostream)
  "Serializes a message object of type '<TakeApmLapseLock-response>"
  (cl:let* ((signed (cl:slot-value msg 'nb_holders)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TakeApmLapseLock-response>) istream)
  "Deserializes a message object of type '<TakeApmLapseLock-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nb_holders) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TakeApmLapseLock-response>)))
  "Returns string type for a service object of type '<TakeApmLapseLock-response>"
  "ardupilot_sitl_gazebo_plugin/TakeApmLapseLockResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TakeApmLapseLock-response)))
  "Returns string type for a service object of type 'TakeApmLapseLock-response"
  "ardupilot_sitl_gazebo_plugin/TakeApmLapseLockResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TakeApmLapseLock-response>)))
  "Returns md5sum for a message object of type '<TakeApmLapseLock-response>"
  "88fb6d40bf2b0fa731238774f37356ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TakeApmLapseLock-response)))
  "Returns md5sum for a message object of type 'TakeApmLapseLock-response"
  "88fb6d40bf2b0fa731238774f37356ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TakeApmLapseLock-response>)))
  "Returns full string definition for message of type '<TakeApmLapseLock-response>"
  (cl:format cl:nil "int32 nb_holders~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TakeApmLapseLock-response)))
  "Returns full string definition for message of type 'TakeApmLapseLock-response"
  (cl:format cl:nil "int32 nb_holders~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TakeApmLapseLock-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TakeApmLapseLock-response>))
  "Converts a ROS message object to a list"
  (cl:list 'TakeApmLapseLock-response
    (cl:cons ':nb_holders (nb_holders msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'TakeApmLapseLock)))
  'TakeApmLapseLock-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'TakeApmLapseLock)))
  'TakeApmLapseLock-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TakeApmLapseLock)))
  "Returns string type for a service object of type '<TakeApmLapseLock>"
  "ardupilot_sitl_gazebo_plugin/TakeApmLapseLock")