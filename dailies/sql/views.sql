drop view if exists act_opp ;
create view act_opp as
select from_id as activity_id, to_id as opportunity_id
from links
where from_table = "activities" and to_table = "opportunities"
union
select to_id as activity_id, from_id as opportunity_id
from links
where from_table = "opportunities" and to_table = "activities"
;

drop view if exists act_opp_lines ;
create view act_opp_lines as
select aov.activity_id, aov.opportunity_id, date(act.activity_start) as start_date, act.user_id
from act_opp aov, activities act
where aov.activity_id = act.activity_id
order by act.activity_start;
;

drop view if exists act_opp_lines_detail ;
create view act_opp_lines_detail as
select act.*, aov.opportunity_id
from act_opp aov, activities act
where aov.activity_id = act.activity_id
order by act.activity_start;
;


