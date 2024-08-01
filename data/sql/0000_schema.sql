create table message
(
        txt longvarchar
);
/
create table relationship
(
        relationshipid integer,
        name longvarchar,
        constraint relationship_primary_key primary key (relationshipid)
);
/
create table restriction
(
        restrictionid integer,
        name longvarchar,
        relationshipid integer,
        q double,
        coeffs double array default array[],
        constraint restriction_primary_key primary key (restrictionid)
);
/

alter table restriction add constraint r1_restriction foreign key (relationshipid) references relationship (relationshipid) on delete set null;
/