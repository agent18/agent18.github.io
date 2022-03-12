;; https://www.youtube.com/watch?v=2z-YBsd5snY&list=WL&index=4
;; https://harryrschwartz.com/2014/04/08/an-introduction-to-emacs-lisp.html
1

path-separator

"foo"

(+ 1 2 3) 

(+ (* 2 3)
   (/ 8 4)) ; first value is the function and the rest we recursively evaluate

;; ' or quote or list to use without evaling it 
(quote (1 2 3))

'(1 2 3)

'(+ 1 2 3)

(message "hello, minibuffer")

(insert " ; inserted test!") ; inserts text at the point of the buffer

;; Lists

(quote (1 2 3))

(list 1 2 3)


(car '(1 2 3)); The simplest function is car, which just returns the first element of the list.

(cdr '(1 2 3)); Conversely, cdr returns the list minus the first element.

'() ; same as nil

nil

(null nil) ; t or nil (doubles as a false)

(cdr '(42))

(cons 1 '(2 3)) ; builds up list 

(append '(1) '(2 3)); needs list period!

(cons '(1 2) '(2 3)); first element is (1 2) and then the third
					; element is 2 and then 3


;; variables

undefined-list

;; global
(set 'some-list '(1 2 3)); setting a value to point to.

some-list

;; global
(setq my-list '(foo bar baz))
					; quotes first arg and 

my-list


;; let local variables

(let ((a 1)
      (b 5))
  (+ b a))

(let ((a 1)
      (b 5))
  (format "a is %d and b is %d" a b))

(let* ((a 3)
       (b (+ a 5)))
  (+ a b))

;; defining fucntions

(defun say-hello ()
  (message "hello!"))

(say-hello)

(defun square (x)
  (* x x))

(square 2)

(defun distance (x1 y1 x2 y2)
  (sqrt (+ (square (- x2 x1))
           (square (- y2 y1)))))


(distance 3 0 0 4)

(when (= (+ 2 2) 4)
  "passed sanity check!")

(defun evens-or-odds (n)
  (if (= 0 (% n 2))
      "even!"
    "odd!"))

(evens-or-odds 4)
(evens-or-odds 3)

;;;;;; cond or case

(defun pick-a-word (n)
  (cond
   ((= n 1) "bulbous")
   ((= n 2) "bouffant")
   ((= n 3) "beluga")
   (t "gazebo!"))) ;; t evals to true

(pick-a-word 2)
; => "bouffant"

(pick-a-word -72)
; => "gazebo!"

(defun factorial (n)
  "pandian le"
  (if (< n 1)
      1
    (* n (factorial (- n 1)))))

(factorial 20)
; => 120

;; anonymous function

(lambda (x) (* x x x))

((lambda (x) (* x x x)) 5)

(funcall (lambda (x) (* x x x)) 3)

(fset 'cube (lambda (x) (* x x x)))

(cube 4)
					; a symbol can be interpreted as a function or a variable
					; space

(setq cube 4)

(cube 4)

cube


;; other functions

(mapcar 'upcase '("foo" "bar" "baz"))
; => ("FOO" "BAR" "BAZ")


(oddp 3)

(remove-if-not 'oddp '(0 1 2 3 4 5 6 7 8 9))
; => (1 3 5 7 9)

;;;;;;;  keybindings

(global-set-key (kbd "M-#") 'sort-lines)

major-mode

;; hook code gets executed when you change to a mode

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (local-set-key (kbd "M-$") 'sort-lines)))

;; documentation

(kbd "C-h k")
; ^Hk

;; C-h k and type the key to know what it does

;; C-h a (search for commands that are similare to "string")

;; C-h f (describe functions)

;; C-h v describe variable
