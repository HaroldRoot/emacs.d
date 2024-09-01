;;; hello-world.el --- Echo "Hello, world!"
;;; Commentary:
;;; Code:

(defun hello-world ()
  "Echo 'Hello, world!'."
  (interactive)
  (message "Hello, world!"))

(provide 'hello-world)

;;; hello-world.el ends here
