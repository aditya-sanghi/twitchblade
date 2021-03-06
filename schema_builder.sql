\c staging;
create table user_info(user_id serial, user_name varchar(40) NOT NULL, password varchar NOT NULL, constraint user_info_pkey primary key (user_id));
create table followers(user_id integer, following_user_id integer NOT NULL, constraint user_idfk foreign key(user_id) references user_info(user_id) on delete cascade on update cascade, constraint friend_user_fk foreign key (following_user_id) references user_info(user_id) on delete cascade on update cascade );
create table tweets(tweet_id serial, tweet_content varchar, user_id integer NOT NULL, lastmodified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,constraint pkey primary key (tweet_id), constraint fkey foreign key (user_id) references user_info(user_id) match simple on update cascade on delete cascade);
create table retweets(tweet_id integer not null, tweet_id_retweeted_from integer not null, origin_tweet_id integer not null, constraint tweet_id_fk foreign key (tweet_id) references tweets(tweet_id) on delete cascade on update cascade, constraint retweet_id_fk foreign key (tweet_id_retweeted_from) references tweets(tweet_id) on delete cascade on update cascade, constraint origin_tweet_id_fk foreign key (origin_tweet_id) references tweets(tweet_id) on delete cascade on update cascade );
alter table user_info owner to twitchblade;
alter table tweets owner to twitchblade;
alter table followers owner to twitchblade;
alter table retweets owner to twitchblade;