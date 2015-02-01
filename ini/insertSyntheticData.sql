

/* 
You maybe must enable LOCAL DATA LOCAL manually first.
  mysql -u myuser -p --local-infile somedatabase
*/


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/coach.txt' INTO TABLE coach COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/address.txt' INTO TABLE address COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/game.txt' INTO TABLE game COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";

load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/hold_at.txt' INTO TABLE hold_at COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/live_at.txt' INTO TABLE live_at COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/locate.txt' INTO TABLE locate COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/player.txt' INTO TABLE player COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/player_for.txt' INTO TABLE play_for COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/university.txt' INTO TABLE university COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


load DATA LOCAL INFILE '/home/qili/Downloads/proj2/generateData/work_for.txt' INTO TABLE work_for COLUMNS TERMINATED BY "\t" LINES TERMINATED BY "\n";


