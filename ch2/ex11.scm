(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval x
                (make-interval (- (upper-bound y))
                               (- (lower-bound y)))))

(define (mul-interval x y)
  (let ((lx (lower-bound x))
        (hx (upper-bound x))
        (ly (lower-bound y))
        (hy (upper-bound y)))
    (cond ((and (>= lx 0) (>= hx 0) (>= ly 0) (>= hy 0))
           (make-interval (* lx ly) (* hx hy)))
          ((and (>= lx 0) (>= hx 0) (< ly 0) (>= hy 0))
           (make-interval (* hx ly) (* hx hy)))
          ((and (>= lx 0) (>= hx 0) (< ly 0) (< hy 0))
           (make-interval (* hx ly) (* lx hy)))
          ((and (< lx 0) (>= hx 0) (>= ly 0) (>= hy 0))
           (make-interval (* lx hy) (* hx hy)))
          ((and (< lx 0) (>= hx 0) (< ly 0) (>= hy 0))
           (make-interval (min (* hx ly) (* lx hy))
                          (max (* hx hy) (* lx ly))))
          ((and (< lx 0) (>= hx 0) (< ly 0) (< hy 0))
           (make-interval (* hx ly) (* lx ly)))
          ((and (< lx 0) (< hx 0) (>= ly 0) (>= hy 0))
           (make-interval (* lx hy) (* hx ly)))
          ((and (< lx 0) (< hx 0) (< ly 0) (>= hy 0))
           (make-interval (* lx hy) (* lx ly)))
          ((and (< lx 0) (< hx 0) (< ly 0) (< hy 0))
           (make-interval (* hx hy) (* lx ly))))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0)
           (>= (upper-bound y) 0))
      (error "won't divide by an interval spanning zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

; test it
(mul-interval (make-interval 2 3) (make-interval 4 5))
(mul-interval (make-interval 2 3) (make-interval -4 5))
(mul-interval (make-interval 2 3) (make-interval -5 -4))
(mul-interval (make-interval -2 3) (make-interval 4 5))
(mul-interval (make-interval -2 3) (make-interval -4 5))
(mul-interval (make-interval -2 3) (make-interval -5 -4))
(mul-interval (make-interval -3 -2) (make-interval 4 5))
(mul-interval (make-interval -3 -2) (make-interval -4 5))
(mul-interval (make-interval -3 -2) (make-interval -5 -4))

