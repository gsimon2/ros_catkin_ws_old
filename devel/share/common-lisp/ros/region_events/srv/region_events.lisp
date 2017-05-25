; Auto-generated. Do not edit!


(cl:in-package region_events-srv)


;//! \htmlinclude region_events-request.msg.html

(cl:defclass <region_events-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass region_events-request (<region_events-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <region_events-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'region_events-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name region_events-srv:<region_events-request> is deprecated: use region_events-srv:region_events-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <region_events-request>) ostream)
  "Serializes a message object of type '<region_events-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <region_events-request>) istream)
  "Deserializes a message object of type '<region_events-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<region_events-request>)))
  "Returns string type for a service object of type '<region_events-request>"
  "region_events/region_eventsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'region_events-request)))
  "Returns string type for a service object of type 'region_events-request"
  "region_events/region_eventsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<region_events-request>)))
  "Returns md5sum for a message object of type '<region_events-request>"
  "9df8f2f743a5e6ba6981f0ecdb4d3549")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'region_events-request)))
  "Returns md5sum for a message object of type 'region_events-request"
  "9df8f2f743a5e6ba6981f0ecdb4d3549")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<region_events-request>)))
  "Returns full string definition for message of type '<region_events-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'region_events-request)))
  "Returns full string definition for message of type 'region_events-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <region_events-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <region_events-request>))
  "Converts a ROS message object to a list"
  (cl:list 'region_events-request
))
;//! \htmlinclude region_events-response.msg.html

(cl:defclass <region_events-response> (roslisp-msg-protocol:ros-message)
  ((stepped
    :reader stepped
    :initarg :stepped
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass region_events-response (<region_events-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <region_events-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'region_events-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name region_events-srv:<region_events-response> is deprecated: use region_events-srv:region_events-response instead.")))

(cl:ensure-generic-function 'stepped-val :lambda-list '(m))
(cl:defmethod stepped-val ((m <region_events-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader region_events-srv:stepped-val is deprecated.  Use region_events-srv:stepped instead.")
  (stepped m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <region_events-response>) ostream)
  "Serializes a message object of type '<region_events-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stepped) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <region_events-response>) istream)
  "Deserializes a message object of type '<region_events-response>"
    (cl:setf (cl:slot-value msg 'stepped) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<region_events-response>)))
  "Returns string type for a service object of type '<region_events-response>"
  "region_events/region_eventsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'region_events-response)))
  "Returns string type for a service object of type 'region_events-response"
  "region_events/region_eventsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<region_events-response>)))
  "Returns md5sum for a message object of type '<region_events-response>"
  "9df8f2f743a5e6ba6981f0ecdb4d3549")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'region_events-response)))
  "Returns md5sum for a message object of type 'region_events-response"
  "9df8f2f743a5e6ba6981f0ecdb4d3549")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<region_events-response>)))
  "Returns full string definition for message of type '<region_events-response>"
  (cl:format cl:nil "bool stepped~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'region_events-response)))
  "Returns full string definition for message of type 'region_events-response"
  (cl:format cl:nil "bool stepped~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <region_events-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <region_events-response>))
  "Converts a ROS message object to a list"
  (cl:list 'region_events-response
    (cl:cons ':stepped (stepped msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'region_events)))
  'region_events-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'region_events)))
  'region_events-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'region_events)))
  "Returns string type for a service object of type '<region_events>"
  "region_events/region_events")