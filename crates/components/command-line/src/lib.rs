use std::cell::OnceCell;
use std::sync::{Arc, OnceLock};
use mizer_command_executor::*;
// use crate::ast::{Ast, Target};
use crate::parser::Tokens;

mod parser;
mod ast;


trait Command: Send + Sync {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl>;
}

pub fn try_parse_as_command(input: &str) -> anyhow::Result<CommandImpl> {
    let tokens = parser::parse(input)?;
    let commands = todo!(); // static access;
    
    let command = commands.iter().find_map(|command| command.try_parse(&tokens))
        .ok_or_else(|| anyhow::anyhow!("Invalid command"))?;
    
    Ok(command)
    
    // let ast = ast::parse(tokens)?;

    // let command = match ast {
    //     Ast::Delete(Target::Sequence(id)) => DeleteSequenceCommand {
    //         sequence_id: id,
    //     }.into(),
    //     Ast::Delete(Target::Group(id)) => DeleteGroupCommand {
    //         id: id.into(),
    //     }.into(),
    //     Ast::Select(Target::Fixture(selection)) => SelectFixturesCommand {
    //         fixtures: selection.into(),
    //     }.into(),
    //     Ast::Store(Target::Sequence(id)) => todo!("StoreProgrammerInSequenceCommand should fetch data from Programmer itself"), /*StoreProgrammerInSequenceCommand {
    //         sequence_id: id,
    //         presets: todo!()
    //     }.into()*/
    //     Ast::Store(Target::Group(id)) => todo!("AssignFixturesToGroupCommand should fetch data from Programmer itself"), /*{
    //         AssignFixturesToGroupCommand {
    //             group_id: id.into(),
    //             fixture_ids: todo!("AssignFixturesToGroupCommand should fetch data from Programmer itself"),
    //         }.into()
    //     },*/
    //     Ast::Highlight => ToggleHighlightCommand.into(),
    //     Ast::Clear => ClearProgrammerCommand.into(),
    //     _ => anyhow::bail!("Invalid command"),
    // };
    // 
    // Ok(command)
}

