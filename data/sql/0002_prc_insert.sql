create procedure message_insert (
in v_txt longvarchar
)
modifies sql data begin atomic
insert into message (
txt
) values (
v_txt
);
end;
/
create procedure relationship_insert (
in v_relationshipid integer,
in v_name longvarchar
)
modifies sql data begin atomic
insert into relationship (
relationshipid,
name
) values (
v_relationshipid,
v_name
);
end;
/
create procedure restriction_insert (
in v_restrictionid integer,
in v_name longvarchar,
in v_relationshipid integer,
in v_q double,
in v_coeffs double array
)
modifies sql data begin atomic
insert into restriction (
restrictionid,
name,
relationshipid,
q,
coeffs
) values (
v_restrictionid,
v_name,
v_relationshipid,
v_q,
v_coeffs
);
end;
/