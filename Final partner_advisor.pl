:- use_module(library(pce)).
% -------------------------------
% Future Partner Type Advisor
% -------------------------------
% suitable_partner(Personality, Lifestyle, Value, PartnerType).

% --------rules------------

% Kind personalities
suitable_partner(kind, calm, honest, caring).
suitable_partner(kind, calm, caring, supportive).
suitable_partner(kind, calm, supportive, caring).
suitable_partner(kind, calm, ambitious, supportive).
suitable_partner(kind, active, honest, supportive).
suitable_partner(kind, active, caring, ambitious).
suitable_partner(kind, active, supportive, ambitious).
suitable_partner(kind, active, ambitious, caring).
suitable_partner(kind, family_oriented, honest, caring).
suitable_partner(kind, family_oriented, caring, responsible).
suitable_partner(kind, family_oriented, supportive, protective).
suitable_partner(kind, family_oriented, ambitious, supportive).
suitable_partner(kind, career_focused, honest, supportive).
suitable_partner(kind, career_focused, caring, ambitious).
suitable_partner(kind, career_focused, supportive, caring).
suitable_partner(kind, career_focused, ambitious, responsible).

% Serious personalities
suitable_partner(serious, calm, honest, funny).
suitable_partner(serious, calm, caring, supportive).
suitable_partner(serious, calm, supportive, caring).
suitable_partner(serious, calm, ambitious, funny).
suitable_partner(serious, active, honest, responsible).
suitable_partner(serious, active, caring, supportive).
suitable_partner(serious, active, supportive, responsible).
suitable_partner(serious, active, ambitious, caring).
suitable_partner(serious, family_oriented, honest, protective).
suitable_partner(serious, family_oriented, caring, supportive).
suitable_partner(serious, family_oriented, supportive, caring).
suitable_partner(serious, family_oriented, ambitious, supportive).
suitable_partner(serious, career_focused, honest, ambitious).
suitable_partner(serious, career_focused, caring, responsible).
suitable_partner(serious, career_focused, supportive, ambitious).
suitable_partner(serious, career_focused, ambitious, caring).

% Adventurous personalities
suitable_partner(adventurous, calm, honest, supportive).
suitable_partner(adventurous, calm, caring, protective).
suitable_partner(adventurous, calm, supportive, caring).
suitable_partner(adventurous, calm, ambitious, responsible).
suitable_partner(adventurous, active, honest, fun_loving).
suitable_partner(adventurous, active, caring, supportive).
suitable_partner(adventurous, active, supportive, ambitious).
suitable_partner(adventurous, active, ambitious, caring).
suitable_partner(adventurous, family_oriented, honest, supportive).
suitable_partner(adventurous, family_oriented, caring, responsible).
suitable_partner(adventurous, family_oriented, supportive, protective).
suitable_partner(adventurous, family_oriented, ambitious, caring).
suitable_partner(adventurous, career_focused, honest, ambitious).
suitable_partner(adventurous, career_focused, caring, responsible).
suitable_partner(adventurous, career_focused, supportive, ambitious).
suitable_partner(adventurous, career_focused, ambitious, caring).

% Fun-loving personalities
suitable_partner(fun_loving, calm, honest, supportive).
suitable_partner(fun_loving, calm, caring, protective).
suitable_partner(fun_loving, calm, supportive, caring).
suitable_partner(fun_loving, calm, ambitious, responsible).
suitable_partner(fun_loving, active, honest, fun_loving).
suitable_partner(fun_loving, active, caring, responsible).
suitable_partner(fun_loving, active, supportive, ambitious).
suitable_partner(fun_loving, active, ambitious, caring).
suitable_partner(fun_loving, family_oriented, honest, protective).
suitable_partner(fun_loving, family_oriented, caring, supportive).
suitable_partner(fun_loving, family_oriented, supportive, caring).
suitable_partner(fun_loving, family_oriented, ambitious, responsible).
suitable_partner(fun_loving, career_focused, honest, ambitious).
suitable_partner(fun_loving, career_focused, caring, responsible).
suitable_partner(fun_loving, career_focused, supportive, ambitious).
suitable_partner(fun_loving, career_focused, ambitious, supportive).

% Creative personalities
suitable_partner(creative, calm, honest, practical).
suitable_partner(creative, calm, caring, supportive).
suitable_partner(creative, calm, supportive, caring).
suitable_partner(creative, calm, ambitious, protective).
suitable_partner(creative, active, honest, supportive).
suitable_partner(creative, active, caring, responsible).
suitable_partner(creative, active, supportive, ambitious).
suitable_partner(creative, active, ambitious, caring).
suitable_partner(creative, family_oriented, honest, protective).
suitable_partner(creative, family_oriented, caring, supportive).
suitable_partner(creative, family_oriented, supportive, responsible).
suitable_partner(creative, family_oriented, ambitious, caring).
suitable_partner(creative, career_focused, honest, ambitious).
suitable_partner(creative, career_focused, caring, responsible).
suitable_partner(creative, career_focused, supportive, ambitious).
suitable_partner(creative, career_focused, ambitious, caring).

% Practical personalities
suitable_partner(practical, calm, honest, creative).
suitable_partner(practical, calm, caring, supportive).
suitable_partner(practical, calm, supportive, caring).
suitable_partner(practical, calm, ambitious, responsible).
suitable_partner(practical, active, honest, responsible).
suitable_partner(practical, active, caring, supportive).
suitable_partner(practical, active, supportive, ambitious).
suitable_partner(practical, active, ambitious, caring).
suitable_partner(practical, family_oriented, honest, protective).
suitable_partner(practical, family_oriented, caring, supportive).
suitable_partner(practical, family_oriented, supportive, responsible).
suitable_partner(practical, family_oriented, ambitious, caring).
suitable_partner(practical, career_focused, honest, ambitious).
suitable_partner(practical, career_focused, caring, responsible).
suitable_partner(practical, career_focused, supportive, ambitious).
suitable_partner(practical, career_focused, ambitious, caring).

% -------------------------------
personality(kind). personality(serious). personality(adventurous).
personality(fun_loving). personality(creative). personality(practical).

lifestyle(calm). lifestyle(active). lifestyle(family_oriented). lifestyle(career_focused).

value(honest). value(caring). value(supportive). value(ambitious).

% fallback mapping: PartnerType = Value
suitable_partner(P, L, V, V) :-
    personality(P), lifestyle(L), value(V).

% GUI
% -------------------------------
start :-
    new(Dialog, dialog('Future Partner Advisor')),

    % Input fields with examples
    send(Dialog, append, new(Personality, text_item('Your Personality (e.g., kind, serious, adventurous, fun_loving, creative, practical)'))),
    send(Dialog, append, new(Lifestyle, text_item('Your Lifestyle (e.g., calm, active, family_oriented, career_focused)'))),
    send(Dialog, append, new(Value, text_item('What do you value most in a partner? (e.g., honest, caring, supportive, ambitious)'))),

    % Button
    send(Dialog, append,
         button('Find My Partner Type',
                message(@prolog, find_partner_type,
                        Personality?selection, Lifestyle?selection, Value?selection))),

    send(Dialog, open).

% Find suitable partner type
find_partner_type(Personality, Lifestyle, Value) :-
    suitable_partner(Personality, Lifestyle, Value, PartnerType),
    !,
    format(atom(Msg), 'Based on your answers, a ~w partner would suit you best!', [PartnerType]),
    new(MsgBox, dialog('Result')),
    send(MsgBox, append, label(text, Msg)),
    send(MsgBox, append, button(ok, message(MsgBox, destroy))),
    send(MsgBox, open).

% Funny fallback if no rule matched
find_partner_type(_, _, _) :-
    new(MsgBox, dialog('Result')),
    send(MsgBox, append, label(text, 'Sorry,You will be single forever-Just fun')),
    send(MsgBox, append, button(ok, message(MsgBox, destroy))),
    send(MsgBox, open).
