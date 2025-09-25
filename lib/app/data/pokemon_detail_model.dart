class PokemonDetailModel {
  PokemonDetailModel({
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  final List<Ability> abilities;
  final int baseExperience;
  final Cries cries;
  final List<Species> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<HeldItem> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<PastAbility> pastAbilities;
  final List<dynamic> pastTypes;
  final Species? species;
  final Sprites? sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  PokemonDetailModel copyWith({
    List<Ability>? abilities,
    int? baseExperience,
    Cries? cries,
    List<Species>? forms,
    List<GameIndex>? gameIndices,
    int? height,
    List<HeldItem>? heldItems,
    int? id,
    bool? isDefault,
    String? locationAreaEncounters,
    List<Move>? moves,
    String? name,
    int? order,
    List<PastAbility>? pastAbilities,
    List<dynamic>? pastTypes,
    Species? species,
    Sprites? sprites,
    List<Stat>? stats,
    List<Type>? types,
    int? weight,
  }) =>
      PokemonDetailModel(
        abilities: abilities ?? this.abilities,
        baseExperience: baseExperience ?? this.baseExperience,
        cries: cries ?? this.cries,
        forms: forms ?? this.forms,
        gameIndices: gameIndices ?? this.gameIndices,
        height: height ?? this.height,
        heldItems: heldItems ?? this.heldItems,
        id: id ?? this.id,
        isDefault: isDefault ?? this.isDefault,
        locationAreaEncounters:
            locationAreaEncounters ?? this.locationAreaEncounters,
        moves: moves ?? this.moves,
        name: name ?? this.name,
        order: order ?? this.order,
        pastAbilities: pastAbilities ?? this.pastAbilities,
        pastTypes: pastTypes ?? this.pastTypes,
        species: species ?? this.species,
        sprites: sprites ?? this.sprites,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        weight: weight ?? this.weight,
      );
}

class Ability {
  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromMap(dynamic data) {
    final json = data as Map<String, dynamic>;
    return Ability(
      ability:
          json['ability'] != null ? Species.fromMap(json['ability']) : null,
      isHidden: json['is_hidden'] as bool,
      slot: json['slot'] as int,
    );
  }
  final Species? ability;
  final bool isHidden;
  final int slot;

  Ability copyWith({
    Species? ability,
    bool? isHidden,
    int? slot,
  }) =>
      Ability(
        ability: ability ?? this.ability,
        isHidden: isHidden ?? this.isHidden,
        slot: slot ?? this.slot,
      );

  Map<String, dynamic> toMap() => {
        'ability': ability?.toMap(),
        'is_hidden': isHidden,
        'slot': slot,
      };
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromMap(dynamic json) {
    final map = json as Map<String, dynamic>;
    return Species(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
  final String name;
  final String url;

  Species copyWith({
    String? name,
    String? url,
  }) =>
      Species(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };
}

class Cries {
  Cries({
    required this.latest,
    required this.legacy,
  });

  factory Cries.fromMap(Map<String, dynamic> json) => Cries(
        latest: json['latest'] as String,
        legacy: json['legacy'] as String,
      );
  final String latest;
  final String legacy;

  Cries copyWith({
    String? latest,
    String? legacy,
  }) =>
      Cries(
        latest: latest ?? this.latest,
        legacy: legacy ?? this.legacy,
      );

  Map<String, dynamic> toMap() => {
        'latest': latest,
        'legacy': legacy,
      };
}

class GameIndex {
  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromMap(Map<String, dynamic> json) => GameIndex(
        gameIndex: json['game_index'] as int,
        version: Species.fromMap(json['version']),
      );
  final int gameIndex;
  final Species version;

  GameIndex copyWith({
    int? gameIndex,
    Species? version,
  }) =>
      GameIndex(
        gameIndex: gameIndex ?? this.gameIndex,
        version: version ?? this.version,
      );

  Map<String, dynamic> toMap() => {
        'game_index': gameIndex,
        'version': version.toMap(),
      };
}

class HeldItem {
  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  factory HeldItem.fromMap(Map<String, dynamic> json) => HeldItem(
        item: Species.fromMap(json['item']),
        versionDetails: List<VersionDetail>.from(
          (json['version_details'] as List<dynamic>).map(VersionDetail.fromMap),
        ),
      );
  final Species item;
  final List<VersionDetail> versionDetails;

  HeldItem copyWith({
    Species? item,
    List<VersionDetail>? versionDetails,
  }) =>
      HeldItem(
        item: item ?? this.item,
        versionDetails: versionDetails ?? this.versionDetails,
      );

  Map<String, dynamic> toMap() => {
        'item': item.toMap(),
        'version_details':
            List<dynamic>.from(versionDetails.map((x) => x.toMap())),
      };
}

class VersionDetail {
  VersionDetail({
    required this.rarity,
    required this.version,
  });

  factory VersionDetail.fromMap(dynamic json) {
    final map = json as Map<String, dynamic>;
    return VersionDetail(
      rarity: map['rarity'] as int,
      version: Species.fromMap(map['version']),
    );
  }
  final int rarity;
  final Species version;

  VersionDetail copyWith({
    int? rarity,
    Species? version,
  }) =>
      VersionDetail(
        rarity: rarity ?? this.rarity,
        version: version ?? this.version,
      );

  Map<String, dynamic> toMap() => {
        'rarity': rarity,
        'version': version.toMap(),
      };
}

class Move {
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromMap(Map<String, dynamic> json) => Move(
        move: Species.fromMap(json['move']),
        versionGroupDetails: List<VersionGroupDetail>.from(
          (json['version_group_details'] as List<dynamic>)
              .map(VersionGroupDetail.fromMap),
        ),
      );
  final Species move;
  final List<VersionGroupDetail> versionGroupDetails;

  Move copyWith({
    Species? move,
    List<VersionGroupDetail>? versionGroupDetails,
  }) =>
      Move(
        move: move ?? this.move,
        versionGroupDetails: versionGroupDetails ?? this.versionGroupDetails,
      );

  Map<String, dynamic> toMap() => {
        'move': move.toMap(),
        'version_group_details':
            List<dynamic>.from(versionGroupDetails.map((x) => x.toMap())),
      };
}

class VersionGroupDetail {
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.order,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromMap(dynamic data) {
    final map = data as Map<String, dynamic>;
    return VersionGroupDetail(
      levelLearnedAt: map['level_learned_at'] as int,
      moveLearnMethod: Species.fromMap(map['move_learn_method']),
      order: map['order'] as int?,
      versionGroup: Species.fromMap(map['version_group']),
    );
  }
  final int levelLearnedAt;
  final Species moveLearnMethod;
  final int? order;
  final Species versionGroup;

  VersionGroupDetail copyWith({
    int? levelLearnedAt,
    Species? moveLearnMethod,
    int? order,
    Species? versionGroup,
  }) =>
      VersionGroupDetail(
        levelLearnedAt: levelLearnedAt ?? this.levelLearnedAt,
        moveLearnMethod: moveLearnMethod ?? this.moveLearnMethod,
        order: order ?? this.order,
        versionGroup: versionGroup ?? this.versionGroup,
      );

  Map<String, dynamic> toMap() => {
        'level_learned_at': levelLearnedAt,
        'move_learn_method': moveLearnMethod.toMap(),
        'order': order,
        'version_group': versionGroup.toMap(),
      };
}

class PastAbility {
  PastAbility({
    required this.abilities,
    required this.generation,
  });

  factory PastAbility.fromMap(Map<String, dynamic> json) => PastAbility(
        abilities: List<Ability>.from(
          (json['abilities'] as List<dynamic>).map(Ability.fromMap),
        ),
        generation: Species.fromMap(json['generation']),
      );
  final List<Ability> abilities;
  final Species generation;

  PastAbility copyWith({
    List<Ability>? abilities,
    Species? generation,
  }) =>
      PastAbility(
        abilities: abilities ?? this.abilities,
        generation: generation ?? this.generation,
      );

  Map<String, dynamic> toMap() => {
        'abilities': List<dynamic>.from(abilities.map((x) => x.toMap())),
        'generation': generation.toMap(),
      };
}

class GenerationV {
  GenerationV({
    required this.blackWhite,
  });

  factory GenerationV.fromMap(Map<String, dynamic> json) => GenerationV(
        blackWhite: Sprites.fromMap(json['black-white']),
      );
  final Sprites blackWhite;

  GenerationV copyWith({
    Sprites? blackWhite,
  }) =>
      GenerationV(
        blackWhite: blackWhite ?? this.blackWhite,
      );

  Map<String, dynamic> toMap() => {
        'black-white': blackWhite.toMap(),
      };
}

class GenerationIv {
  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  factory GenerationIv.fromMap(Map<String, dynamic> json) => GenerationIv(
        diamondPearl: Sprites.fromMap(json['diamond-pearl']),
        heartgoldSoulsilver: Sprites.fromMap(json['heartgold-soulsilver']),
        platinum: Sprites.fromMap(json['platinum']),
      );
  final Sprites diamondPearl;
  final Sprites heartgoldSoulsilver;
  final Sprites platinum;

  GenerationIv copyWith({
    Sprites? diamondPearl,
    Sprites? heartgoldSoulsilver,
    Sprites? platinum,
  }) =>
      GenerationIv(
        diamondPearl: diamondPearl ?? this.diamondPearl,
        heartgoldSoulsilver: heartgoldSoulsilver ?? this.heartgoldSoulsilver,
        platinum: platinum ?? this.platinum,
      );

  Map<String, dynamic> toMap() => {
        'diamond-pearl': diamondPearl.toMap(),
        'heartgold-soulsilver': heartgoldSoulsilver.toMap(),
        'platinum': platinum.toMap(),
      };
}

class Sprites {
  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Sprites.fromMap(dynamic json) {
    final map = json as Map<String, dynamic>;
    return Sprites(
      backDefault: map['back_default'] as String?,
      backFemale: map['back_female'] as String?,
      backShiny: map['back_shiny'] as String?,
      backShinyFemale: map['back_shiny_female'] as String?,
      frontDefault: map['front_default'] as String?,
      frontFemale: map['front_female'] as String?,
      frontShiny: map['front_shiny'] as String?,
      frontShinyFemale: map['front_shiny_female'] as String?,
    );
  }
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  Sprites copyWith({
    String? backDefault,
    String? backFemale,
    String? backShiny,
    String? backShinyFemale,
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
  }) =>
      Sprites(
        backDefault: backDefault ?? this.backDefault,
        backFemale: backFemale ?? this.backFemale,
        backShiny: backShiny ?? this.backShiny,
        backShinyFemale: backShinyFemale ?? this.backShinyFemale,
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyFemale: frontShinyFemale ?? this.frontShinyFemale,
      );

  Map<String, dynamic> toMap() => {
        'back_default': backDefault,
        'back_female': backFemale,
        'back_shiny': backShiny,
        'back_shiny_female': backShinyFemale,
        'front_default': frontDefault,
        'front_female': frontFemale,
        'front_shiny': frontShiny,
        'front_shiny_female': frontShinyFemale,
      };
}

class RedBlue {
  RedBlue({
    required this.backDefault,
    required this.backGray,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontGray,
    required this.frontTransparent,
  });

  factory RedBlue.fromMap(dynamic data) {
    final map = data as Map<String, dynamic>;
    return RedBlue(
      backDefault: map['back_default'] as String,
      backGray: map['back_gray'] as String,
      backTransparent: map['back_transparent'] as String,
      frontDefault: map['front_default'] as String,
      frontGray: map['front_gray'] as String,
      frontTransparent: map['front_transparent'] as String,
    );
  }

  final String backDefault;
  final String backGray;
  final String backTransparent;
  final String frontDefault;
  final String frontGray;
  final String frontTransparent;

  RedBlue copyWith({
    String? backDefault,
    String? backGray,
    String? backTransparent,
    String? frontDefault,
    String? frontGray,
    String? frontTransparent,
  }) =>
      RedBlue(
        backDefault: backDefault ?? this.backDefault,
        backGray: backGray ?? this.backGray,
        backTransparent: backTransparent ?? this.backTransparent,
        frontDefault: frontDefault ?? this.frontDefault,
        frontGray: frontGray ?? this.frontGray,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );

  Map<String, dynamic> toMap() => {
        'back_default': backDefault,
        'back_gray': backGray,
        'back_transparent': backTransparent,
        'front_default': frontDefault,
        'front_gray': frontGray,
        'front_transparent': frontTransparent,
      };
}

class GenerationIi {
  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  factory GenerationIi.fromMap(Map<String, dynamic> json) => GenerationIi(
        crystal: Crystal.fromMap(json['crystal']),
        gold: Gold.fromMap(json['gold']),
        silver: Gold.fromMap(json['silver']),
      );
  final Crystal crystal;
  final Gold gold;
  final Gold silver;

  GenerationIi copyWith({
    Crystal? crystal,
    Gold? gold,
    Gold? silver,
  }) =>
      GenerationIi(
        crystal: crystal ?? this.crystal,
        gold: gold ?? this.gold,
        silver: silver ?? this.silver,
      );

  Map<String, dynamic> toMap() => {
        'crystal': crystal.toMap(),
        'gold': gold.toMap(),
        'silver': silver.toMap(),
      };
}

class Crystal {
  Crystal({
    required this.backDefault,
    required this.backShiny,
    required this.backShinyTransparent,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontShinyTransparent,
    required this.frontTransparent,
  });

  factory Crystal.fromMap(dynamic json) {
    return Crystal(
      backDefault: json['back_default'] as String,
      backShiny: json['back_shiny'] as String,
      backShinyTransparent: json['back_shiny_transparent'] as String,
      backTransparent: json['back_transparent'] as String,
      frontDefault: json['front_default'] as String,
      frontShiny: json['front_shiny'] as String,
      frontShinyTransparent: json['front_shiny_transparent'] as String,
      frontTransparent: json['front_transparent'] as String,
    );
  }
  final String backDefault;
  final String backShiny;
  final String backShinyTransparent;
  final String backTransparent;
  final String frontDefault;
  final String frontShiny;
  final String frontShinyTransparent;
  final String frontTransparent;

  Crystal copyWith({
    String? backDefault,
    String? backShiny,
    String? backShinyTransparent,
    String? backTransparent,
    String? frontDefault,
    String? frontShiny,
    String? frontShinyTransparent,
    String? frontTransparent,
  }) =>
      Crystal(
        backDefault: backDefault ?? this.backDefault,
        backShiny: backShiny ?? this.backShiny,
        backShinyTransparent: backShinyTransparent ?? this.backShinyTransparent,
        backTransparent: backTransparent ?? this.backTransparent,
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyTransparent:
            frontShinyTransparent ?? this.frontShinyTransparent,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );

  Map<String, dynamic> toMap() => {
        'back_default': backDefault,
        'back_shiny': backShiny,
        'back_shiny_transparent': backShinyTransparent,
        'back_transparent': backTransparent,
        'front_default': frontDefault,
        'front_shiny': frontShiny,
        'front_shiny_transparent': frontShinyTransparent,
        'front_transparent': frontTransparent,
      };
}

class Gold {
  Gold({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontTransparent,
  });

  factory Gold.fromMap(dynamic json) {
    final map = json as Map<String, dynamic>;
    return Gold(
      backDefault: map['back_default'] as String,
      backShiny: map['back_shiny'] as String,
      frontDefault: map['front_default'] as String,
      frontShiny: map['front_shiny'] as String,
      frontTransparent: map['front_transparent'] as String,
    );
  }

  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;
  final String frontTransparent;

  Gold copyWith({
    String? backDefault,
    String? backShiny,
    String? frontDefault,
    String? frontShiny,
    String? frontTransparent,
  }) =>
      Gold(
        backDefault: backDefault ?? this.backDefault,
        backShiny: backShiny ?? this.backShiny,
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );

  Map<String, dynamic> toMap() => {
        'back_default': backDefault,
        'back_shiny': backShiny,
        'front_default': frontDefault,
        'front_shiny': frontShiny,
        'front_transparent': frontTransparent,
      };
}

class GenerationIii {
  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  factory GenerationIii.fromMap(dynamic json) => GenerationIii(
        emerald: OfficialArtwork.fromMap(json['emerald']),
        fireredLeafgreen: Gold.fromMap(json['firered-leafgreen']),
        rubySapphire: Gold.fromMap(json['ruby-sapphire']),
      );
  final OfficialArtwork emerald;
  final Gold fireredLeafgreen;
  final Gold rubySapphire;

  GenerationIii copyWith({
    OfficialArtwork? emerald,
    Gold? fireredLeafgreen,
    Gold? rubySapphire,
  }) =>
      GenerationIii(
        emerald: emerald ?? this.emerald,
        fireredLeafgreen: fireredLeafgreen ?? this.fireredLeafgreen,
        rubySapphire: rubySapphire ?? this.rubySapphire,
      );

  Map<String, dynamic> toMap() => {
        'emerald': emerald.toMap(),
        'firered-leafgreen': fireredLeafgreen.toMap(),
        'ruby-sapphire': rubySapphire.toMap(),
      };
}

class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory OfficialArtwork.fromMap(dynamic json) => OfficialArtwork(
        frontDefault: json['front_default'] as String,
        frontShiny: json['front_shiny'] as String,
      );
  final String frontDefault;
  final String frontShiny;

  OfficialArtwork copyWith({
    String? frontDefault,
    String? frontShiny,
  }) =>
      OfficialArtwork(
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
      );

  Map<String, dynamic> toMap() => {
        'front_default': frontDefault,
        'front_shiny': frontShiny,
      };
}

class GenerationVii {
  GenerationVii({
    required this.icons,
  });

  factory GenerationVii.fromMap(dynamic json) => GenerationVii(
        icons: DreamWorld.fromMap(json['icons']),
      );
  final DreamWorld icons;

  GenerationVii copyWith({
    DreamWorld? icons,
  }) =>
      GenerationVii(
        icons: icons ?? this.icons,
      );

  Map<String, dynamic> toMap() => {
        'icons': icons.toMap(),
      };
}

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  factory DreamWorld.fromMap(dynamic json) {
    return DreamWorld(
      frontDefault: json['front_default'] as String,
      frontFemale: json['front_female'],
    );
  }
  final String frontDefault;
  final dynamic frontFemale;

  DreamWorld copyWith({
    String? frontDefault,
    dynamic frontFemale,
  }) =>
      DreamWorld(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
      );

  Map<String, dynamic> toMap() => {
        'front_default': frontDefault,
        'front_female': frontFemale,
      };
}

class GenerationViii {
  GenerationViii({
    required this.icons,
  });

  factory GenerationViii.fromMap(Map<String, dynamic> json) => GenerationViii(
        icons: DreamWorld.fromMap(json['icons']),
      );
  final DreamWorld icons;

  GenerationViii copyWith({
    DreamWorld? icons,
  }) =>
      GenerationViii(
        icons: icons ?? this.icons,
      );

  Map<String, dynamic> toMap() => {
        'icons': icons.toMap(),
      };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json['base_stat'] as int,
        effort: json['effort'] as int,
        stat: Species.fromMap(json['stat'] as Map<String, dynamic>),
      );
  final int baseStat;
  final int effort;
  final Species stat;

  Stat copyWith({
    int? baseStat,
    int? effort,
    Species? stat,
  }) =>
      Stat(
        baseStat: baseStat ?? this.baseStat,
        effort: effort ?? this.effort,
        stat: stat ?? this.stat,
      );

  Map<String, dynamic> toMap() => {
        'base_stat': baseStat,
        'effort': effort,
        'stat': stat.toMap(),
      };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json['slot'] as int,
        type: Species.fromMap(json['type']),
      );
  final int slot;
  final Species type;

  Type copyWith({
    int? slot,
    Species? type,
  }) =>
      Type(
        slot: slot ?? this.slot,
        type: type ?? this.type,
      );

  Map<String, dynamic> toMap() => {
        'slot': slot,
        'type': type.toMap(),
      };
}
