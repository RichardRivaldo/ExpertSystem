;;; Rule to ask questions regarding attributes that the Expert System needs
;;; All questions should be answered with numbers
(deffunction ask-question (?Attribute)
    (printout t ?Attribute)
    (bind ?answer (read))
    (while (not (numberp ?answer)) do
        (printout t ?Attribute)
        (bind ?answer (read)) 
    )
?answer)


;;; Rules to ask questions regarding parameters of the system
;;; Assert the correlating fact based on user's answer
;;; Will ask as long as the initial fact is still there
;;; Retract the initial fact in the last question
;;; Conflict Resolution Strategy: Depth

(defrule ask-meanConcavePoints
    ?x <- (initial-fact)
    =>
    (bind ?mcp (ask-question "mean_concave_points ? ")) 
    (assert (mean_concave_points ?mcp))
)

(defrule ask-perimeterError
    ?x <- (initial-fact)
    =>
    (bind ?perimeter_error (ask-question "perimeter_error ? ")) 
    (assert (perimeter_error ?perimeter_error))
)

(defrule ask-meanRadius
    ?x <- (initial-fact)
    =>
    (bind ?mean_radius (ask-question "mean_radius ? ")) 
    (assert (mean_radius ?mean_radius))
)

(defrule ask-meanTexture
    ?x <- (initial-fact)
    =>
    (bind ?meanTexture (ask-question "meanTexture ? ")) 
    (assert (meanTexture ?meanTexture))
)

(defrule ask-concavePointsError
    ?x <- (initial-fact)
    =>
    (bind ?concave_points_error (ask-question "concave_points_error ? ")) 
    (assert (concave_points_error ?concave_points_error))
)

(defrule ask-radiusError
    ?x <- (initial-fact)
    =>
    (bind ?radius_error (ask-question "radius_error ? ")) 
    (assert (radius_error ?radius_error))
)

(defrule ask-mainSmoothness
    ?x <- (initial-fact)
    =>
    (bind ?main_smoothness (ask-question "main_smoothness ? ")) 
    (assert (main_smoothness ?main_smoothness))
)

(defrule ask-worstRadius
    ?x <- (initial-fact)
    =>
    (bind ?worstRadius (ask-question "worstRadius ? ")) 
    (assert (worstRadius ?worstRadius))
)

(defrule ask-worstArea
    ?x <- (initial-fact)
    =>
    (bind ?worst_area (ask-question "worst_area ? ")) 
    (assert (worst_area ?worst_area))
)

(defrule ask-worstPerimeter
    ?x <- (initial-fact)
    =>
    (bind ?worst_perimeter (ask-question "worst_perimeter ? ")) 
    (assert (worst_perimeter ?worst_perimeter))
)

(defrule ask-worstTexture
    ?x <- (initial-fact)
    =>
    (bind ?worst_texture (ask-question "worst_texture ? ")) 
    (assert (worst_texture ?worst_texture))
)

(defrule ask-worstConcavePoints
    ?x <- (initial-fact)
    =>
    (retract ?x)
    (bind ?worst_concave_points (ask-question "worst_concave_points ? ")) 
    (assert (worst_concave_points ?worst_concave_points))
)

