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
    (bind ?mean_concave_points (ask-question "mean_concave_points ? ")) 
    (assert (mean_concave_points ?mean_concave_points))
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
    (bind ?mean_texture (ask-question "meanTexture ? ")) 
    (assert (mean_texture ?mean_texture))
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
    (bind ?worst_radius (ask-question "worstRadius ? ")) 
    (assert (worst_radius ?worst_radius))
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
    (assert (filterBy mean_concave_points))
)

;;; Rules to process facts of parameters from the user

(defrule filterBy-meanConcavePoints
    (mean_concave_points ?mcp)
    (filterBy mean_concave_points)
    =>
    (if (> ?mcp 0.05) 
        then (assert (filterBy worst_perimeter))
    else (assert(filterBy worst_radius))
    )
)

(defrule filterBy-worstPerimeter
    (worst_perimeter ?worst_perimeter)
    (filterBy worst_perimeter)
    =>
    (if (> ?worst_perimeter 114.45)
        then (assert (breast_cancer false))
    else (assert (filterBy worst_texture_right))
    ) 
)

(defrule filterBy-worstRadius
    (worst_radius ?worst_radius)
    (filterBy worst_radius)
    =>
    (if (> ?worst_radius 16.83)
        then (assert (filterBy radius_error))
    else (assert (filterBy mean_texture_up))
    ) 
)

(defrule filterBy-radiusError
    (radius_error ?radius_error)
    (filterBy radius_error)
    =>
    (if (> ?radius_error 0.63)
        then (assert (filterBy mean_smoothness))
    else (assert (filterBy worst_texture_left))
    ) 
)

(defrule filterBy-meanTexture-Up
    (mean_texture ?mean_texture
    (filterBy mean_texture_up)
    =>
    (if (> ?mean_texture 16.19)
        then (assert (filterBy concave_points_error))
    else (assert (breast_cancer true))
    ) 
)

(defrule filterBy-worstTexture-Left
    (worst_texture ?worst_texture)
    (filterBy worst_texture_left)
    =>
    (if (> ?worst_texture 30.15)
        then (assert (filterBy worst_area))
    else (assert (breast_cancer true))
    ) 
)

(defrule filterBy-meanSmoothness
    (mean_smoothness ?mean_smoothness)
    (filterBy mean_smoothness)
    =>
    (if (> ?mean_smoothness 0.09)
        then (assert (breast_cancer false))
    else (assert (breast_cancer true))
    ) 
)

(defrule filterBy-concavePointsError
    (concave_points_error ?concave_points_error)
    (filterBy concave_points_error)
    =>
    (if (> ?concave_points_error 0.01)
        then (assert (breast_cancer true))
    else (assert (breast_cancer false))
    ) 
)


(defrule filterBy-worstArea
    (worst_area ?worst_area)
    (filterBy worst_area)
    =>
    (if (> ?worst_area 641.60)
        then (assert (filterBy mean_radius_left))
    else (assert (breast_cancer true))
    ) 
)

(defrule filterBy-meanRadius-Left
    (mean_radius ?mean_radius)
    (filterBy mean_radius_left)
    =>
    (if (> ?mean_radius 13.45)
        then (assert (breast_cancer true))
    else (assert (filterBy mean_texture_bottom))
    ) 
)

(defrule filterBy-meanTexture-Bottom
    (mean_texture ?mean_texture)
    (filterBy mean_texture_bottom)
    =>
    (if (> ?mean_texture 28.79)
        then (assert (breast_cancer true))
    else (assert (breast_cancer false))
    ) 
)

(defrule filterBy-worstTexture-Right
    (worst_texture ?worst_texture)
    (filterBy worst_texture_right)
    =>
    (if (> ?worst_texture 25.65)
        then (assert (filterBy perimeter_error))
    else (assert (filterBy worst_concave_points))
    )
)

(defrule filterBy-worstConcavePoints
    (worst_concave_points ?worst_concave_points)
    (filterBy worst_concave_points)
    =>
    (if (> ?worst_concave_points 0.17)
        then (assert (breast_cancer false))
    else (assert (breast_cancer true))
    )
)

(defrule filterBy-perimeterError
    (perimeter_error ?perimeter_error)
    (filterBy perimeter_error)
    =>
    (if (> ?perimeter_error 1.56)
        then (assert (breast_cancer false))
    else (assert (filterBy mean_radius_right))
    )
)

(defrule filterBy-meanRadius-Right
    (mean_radius ?mean_radius)
    (filterBy mean_radius_right)
    =>
    (if (> ?mean_radius 13.34)
        then (assert (breast_cancer true))
    else (assert (breast_cancer false))
    )
)

(defrule cancerDetected
    (breast_cancer true)
    =>
    (retract *)
	(printout t "*****************************" crlf)
	(printout t "* We are sorry for your loss!" crlf)
	(printout t "* We detected a breast cancer" crlf)
	(printout t "* Stop nubes and go rest pls!" crlf)
	(printout t "*****************************" crlf)
)

(defrule cancerNotDetected
    (breast_cancer false)
    =>
    (retract *)
	(printout t "*****************************" crlf)
	(printout t "* Here's a good news for you!" crlf)
	(printout t "* Detected no breast cancer!!" crlf)
	(printout t "* Even so, stop nubes please!" crlf)
	(printout t "*****************************" crlf)
)