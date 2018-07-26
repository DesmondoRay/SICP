;;; exercise 4.59

; a)
(meeting ?department (Friday ?time))

; b)
(rule (meeting-time ?person ?day-and-time)
      (and (job ?person (?department . ?work))
           (or (meeting ?department ?day-and-time) ; 部门会议
               (meeting the-whole-company ?day-and-time)))) ; 公司会议

; c)
(meeting-time (Hacker Alyssa P) (Wednesday . ?time))


