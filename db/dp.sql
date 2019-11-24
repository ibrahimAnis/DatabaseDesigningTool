


insert into member_address (member_code,address,effective_from) values(6,"Vasant vihar Ujjain",'2017/01/01');
insert into member_address (member_code,address,effective_from) values(7,"Tripti Vihar Ujjain",'2017/01/02');
insert into member_address (member_code,address,effective_from) values(8,"Nanakheda Bus Stand",'2017/02/01');
insert into member_address (member_code,address,effective_from) values(9,"Vasant nagar Ujjain",'2017/01/01');
insert into member_address (member_code,address,effective_from) values(10,"KD Gate Ujjain",'2017/01/03');


insert into subscription_plan (effective_from,monthly_rate,yearly_rate,free_projects,free_tables) values('2017/01/01',500,1000,5,25);

insert into member_subscription(invoice_date,member_code,subscription_plan_code,plan_type,quantity,rate,effective_from,effective_upto)
values('2017/01/01',6,1,'m',3,500,'2017/01/01','2017/03/02');
insert into member_subscription(invoice_date,member_code,subscription_plan_code,plan_type,quantity,rate,effective_from,effective_upto)
values('2017/01/01',9,1,'y',1,1000,'2017/01/01','2017/03/03');
insert into member_subscription(invoice_date,member_code,subscription_plan_code,plan_type,quantity,rate,effective_from,effective_upto)
values('2017/01/01',10,1,'m',2,500,'2017/01/04','2017/03/03');
