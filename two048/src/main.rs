use bevy::prelude::*;
use itertools::Itertools;
mod colors;

const TILE_SIZE: f32 = 40.0;
const TILE_SPACER: f32 = 10.0;

fn main() {
    App::new()
        .insert_resource(ClearColor(
            Color::hex("#1f2638").unwrap(),
        ))
        .add_plugins(DefaultPlugins.set(
            WindowPlugin {
                primary_window: Some(Window {
                    title: "2048".to_string(),
                    ..default()
                }),
                ..default()
            }
        ))
        .add_systems(Startup, setup)
        .add_systems(Startup, spawn_board)
        .run();
}

#[derive(Component)]
struct Board {
    size: u8,
    physical_size: f32,
}

#[derive(Component)]
struct Points {
    value: u32,
}

#[derive(Component)]
struct Position {
    x: u8,
    y: u8,
}

impl Board {
    fn new(size: u8) -> Self {
        let physical_size = f32::from(size) * TILE_SIZE + f32::from(size + 1) * TILE_SPACER;
        return Board { size, physical_size };
    }

    fn cell_position_to_physical(&self, pos: u8) -> f32 {
        let offset = -self.physical_size / 2.0 + 0.5 * TILE_SIZE;

        return offset + f32::from(pos) * TILE_SIZE + f32::from(pos + 1) * TILE_SPACER;
    }
}

fn spawn_tiles(
    mut commands: Commands,
    query_board: Query<&Board>,
) {
    let board = query_board.single();
    
}

fn spawn_board(mut commands: Commands) {
    let board = Board::new(4);

    commands
        .spawn(
            SpriteBundle {
                sprite: Sprite {
                    color: colors::BOARD,
                    custom_size: Some(Vec2::new(
                        board.physical_size,
                        board.physical_size
                    )),
                    ..default()
                },
                ..default()
            }
        )
        .with_children(|builder| {
            for tile in (0..board.size).cartesian_product(0..board.size) {
                builder.spawn(SpriteBundle {
                    sprite: Sprite {
                        color: colors::TILE_PLACEHOLDER,
                        custom_size: Some(Vec2::new(TILE_SIZE, TILE_SIZE)),
                        ..default()
                    },
                    transform: Transform::from_xyz(
                        board.cell_position_to_physical(tile.0),
                        board.cell_position_to_physical(tile.1),
                        1.0
                    ),
                    ..default()
                });
            };

        })
        .insert(board);
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2dBundle::default());
}