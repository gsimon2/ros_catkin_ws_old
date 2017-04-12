
(cl:in-package :asdf)

(defsystem "ardupilot_sitl_gazebo_plugin-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ReleaseApmLapseLock" :depends-on ("_package_ReleaseApmLapseLock"))
    (:file "_package_ReleaseApmLapseLock" :depends-on ("_package"))
    (:file "TakeApmLapseLock" :depends-on ("_package_TakeApmLapseLock"))
    (:file "_package_TakeApmLapseLock" :depends-on ("_package"))
  ))