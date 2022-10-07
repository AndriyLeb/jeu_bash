run:
	src/jeu.sh

show:
	src/show_leaderboard.sh $(leaderboard)

reset_scores:
	src/reset.sh $(leaderboard)

score_by:
	src/score_by.sh $(pseudo)