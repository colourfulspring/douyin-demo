/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2023/8/28 22:36:54                           */
/*==============================================================*/


drop table if exists Comment;

drop table if exists Favorite;

drop table if exists Follow;

drop table if exists Message;

drop table if exists User;

drop table if exists Video;

/*==============================================================*/
/* Table: Comment                                               */
/*==============================================================*/
create table Comment
(
   comment_id           bigint unsigned not null,
   user_id              bigint unsigned not null,
   video_id             bigint unsigned not null,
   create_date          date not null,
   comment_content      varchar(300) not null,
   primary key (comment_id)
);

/*==============================================================*/
/* Table: Favorite                                              */
/*==============================================================*/
create table Favorite
(
   video_id             bigint unsigned not null,
   user_id              bigint unsigned not null,
   primary key (video_id, user_id)
);

/*==============================================================*/
/* Table: Follow                                                */
/*==============================================================*/
create table Follow
(
   Use_user_id          bigint unsigned not null,
   user_id              bigint unsigned not null,
   primary key (Use_user_id, user_id)
);

/*==============================================================*/
/* Table: Message                                               */
/*==============================================================*/
create table Message
(
   message_id           bigint unsigned not null,
   user_id              bigint unsigned not null,
   Use_user_id          bigint unsigned not null,
   message_content      varchar(300) not null,
   create_time          time not null,
   primary key (message_id)
);

/*==============================================================*/
/* Table: User                                                  */
/*==============================================================*/
create table User
(
   user_id              bigint unsigned not null,
   user_name            varchar(32) not null,
   avatar               char(64),
   background_image     char(64),
   signature            varchar(100),
   password             varchar(32) not null,
   token                varchar(64) not null,
   primary key (user_id)
);

/*==============================================================*/
/* Table: Video                                                 */
/*==============================================================*/
create table Video
(
   video_id             bigint unsigned not null,
   user_id              bigint unsigned not null,
   play_url             char(64) not null,
   cover_url            char(64) not null,
   title                varchar(50) not null,
   primary key (video_id)
);

alter table Comment add constraint FK_CommentUser foreign key (user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Comment add constraint FK_CommentVideo foreign key (video_id)
      references Video (video_id) on delete restrict on update restrict;

alter table Favorite add constraint FK_Favorite foreign key (video_id)
      references Video (video_id) on delete restrict on update restrict;

alter table Favorite add constraint FK_Favorite2 foreign key (user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Follow add constraint FK_Follow foreign key (Use_user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Follow add constraint FK_Follow2 foreign key (user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Message add constraint FK_MessageFromUser foreign key (Use_user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Message add constraint FK_MessageToUser foreign key (user_id)
      references User (user_id) on delete restrict on update restrict;

alter table Video add constraint FK_Publish foreign key (user_id)
      references User (user_id) on delete restrict on update restrict;

