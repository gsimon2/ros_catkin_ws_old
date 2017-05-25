
(cl:in-package :asdf)

(defsystem "region_events-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "region_events" :depends-on ("_package_region_events"))
    (:file "_package_region_events" :depends-on ("_package"))
  ))