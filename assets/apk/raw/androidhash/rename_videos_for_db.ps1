$base = Split-Path -Parent $MyInvocation.MyCommand.Path
$pairs = @(
  @{Old='abdominal_bicicleta.mp4'; New='abdominal_bicicleta_m.mp4'}
  @{Old='abdominal_bicicleta (2).mp4'; New='abdominal_bicicleta_f.mp4'}
  @{Old='abdominal_crunch.mp4'; New='abdominal_crunch_m.mp4'}
  @{Old='abdominal_crunch_haltere.mp4'; New='abdominal_crunch_haltere_m.mp4'}
  @{Old='abdominal_maquina.mp4'; New='abdominal_maquina_m.mp4'}
  @{Old='abdominal_obliquo_solo.mp4'; New='abdominal_obliquo_solo_m.mp4'}
  @{Old='abdominal_russo.mp4'; New='abdominal_russo_m.mp4'}
  @{Old='abdominal_russo_com_halteres.mp4'; New='abdominal_russo_com_halteres_m.mp4'}
  @{Old='abdominal_stomach_vacuum.mp4'; New='abdominal_stomach_vacuum_m.mp4'}
  @{Old='abdominal_supino_solo.mp4'; New='abdominal_supino_solo_m.mp4'}
  @{Old='abdominal_twist_russo.mp4'; New='abdominal_twist_russo_m.mp4'}
  @{Old='afundo_bulgaro_com_haltere.mp4'; New='afundo_bulgaro_com_haltere_m.mp4'}
  @{Old='afundo_halteres.mp4'; New='afundo_halteres_m.mp4'}
  @{Old='afundo_halteres (2).mp4'; New='afundo_halteres_f.mp4'}
  @{Old='agachamento_com_barra.mp4'; New='agachamento_com_barra_m.mp4'}
  @{Old='agachamento_com_salto.mp4'; New='agachamento_com_salto_m.mp4'}
  @{Old='agachamento_costas_barra.mp4'; New='agachamento_costas_barra_m.mp4'}
  @{Old='agachamento_goblet.mp4'; New='agachamento_goblet_m.mp4'}
  @{Old='agachamento_goblet (2).mp4'; New='agachamento_goblet_f.mp4'}
  @{Old='agachamento_isométrico.mp4'; New='agachamento_isometrico_m.mp4'}
  @{Old='agachamento_sumo_haltere.mp4'; New='agachamento_sumo_haltere_m.mp4'}
  @{Old='agachamento_sumo_haltere (2).mp4'; New='agachamento_sumo_haltere_f.mp4'}
  @{Old='alpinista.mp4'; New='alpinista_m.mp4'}
  @{Old='alpinista_mountain_climber.mp4'; New='alpinista_mountain_climber_m.mp4'}
  @{Old='avanco_alternado.mp4'; New='avanco_alternado_m.mp4'}
  @{Old='barra_fixa_pronada.mp4'; New='barra_fixa_pronada_m.mp4'}
  @{Old='burpee.mp4'; New='burpee_m.mp4'}
  @{Old='burpee (2).mp4'; New='burpee_f.mp4'}
  @{Old='cadeira_abdutora.mp4'; New='cadeira_abdutora_m.mp4'}
  @{Old='cadeira_adutora.mp4'; New='cadeira_adutora_m.mp4'}
  @{Old='cadeira_extensora.mp4'; New='cadeira_extensora_m.mp4'}
  @{Old='cadeira_extensora (2).mp4'; New='cadeira_extensora_f.mp4'}
  @{Old='cadeira_flexora.mp4'; New='cadeira_flexora_m.mp4'}
  @{Old='caminhada_esteira.mp4'; New='caminhada_esteira_m.mp4'}
  @{Old='caminhada_na_esteira.mp4'; New='caminhada_na_esteira_m.mp4'}
  @{Old='corrida_esteira_inclinada.mp4'; New='corrida_esteira_inclinada_m.mp4'}
  @{Old='corrida_na_esteira.mp4'; New='corrida_na_esteira_m.mp4'}
  @{Old='corrida_na_esteira (2).mp4'; New='corrida_na_esteira_f.mp4'}
  @{Old='crucifixo_halteres_reto.mp4'; New='crucifixo_halteres_reto_m.mp4'}
  @{Old='crucifixo_horizontal_halteres.mp4'; New='crucifixo_horizontal_halteres_m.mp4'}
  @{Old='crucifixo_polia_media.mp4'; New='crucifixo_polia_media_m.mp4'}
  @{Old='dead_bug.mp4'; New='dead_bug_m.mp4'}
  @{Old='desenvolvimento_arnold.mp4'; New='desenvolvimento_arnold_m.mp4'}
  @{Old='desenvolvimento_arnold_halteres.mp4'; New='desenvolvimento_arnold_halteres_m.mp4'}
  @{Old='desenvolvimento_halteres.mp4'; New='desenvolvimento_halteres_m.mp4'}
  @{Old='desenvolvimento_halteres (2).mp4'; New='desenvolvimento_halteres_f.mp4'}
  @{Old='desenvolvimento_maquina.mp4'; New='desenvolvimento_maquina_m.mp4'}
  @{Old='desenvolvimento_maquina (2).mp4'; New='desenvolvimento_maquina_f.mp4'}
  @{Old='desenvolvimento_ombros_halteres.mp4'; New='desenvolvimento_ombros_halteres_m.mp4'}
  @{Old='desenvolvimento_sentado_com_halteres.mp4'; New='desenvolvimento_sentado_com_halteres_m.mp4'}
  @{Old='elevaçao_frontal_halteres.mp4'; New='elevacao_frontal_halteres_m.mp4'}
  @{Old='elevação_frontal_halteres.mp4'; New='elevacao_frontal_halteres_f.mp4'}
  @{Old='elevacao_lateral_com_halteres.mp4'; New='elevacao_lateral_com_halteres_m.mp4'}
  @{Old='elevaçao_lateral_e_frontal_halteres.mp4'; New='elevacao_lateral_e_frontal_halteres_m.mp4'}
  @{Old='elevaçao_lateral_halteres.mp4'; New='elevacao_lateral_halteres_m.mp4'}
  @{Old='elevacao_lateral_ombros.mp4'; New='elevacao_lateral_ombros_m.mp4'}
  @{Old='elevação_pélvica_com_anilha.mp4'; New='elevacao_pelvica_com_anilha_m.mp4'}
  @{Old='elevacao_pelvica_haltere.mp4'; New='elevacao_pelvica_haltere_m.mp4'}
  @{Old='elevação_pélvica_solo.mp4'; New='elevacao_pelvica_solo_m.mp4'}
  @{Old='encolhimento_halteres.mp4'; New='encolhimento_halteres_m.mp4'}
  @{Old='escada_ergometrica.mp4'; New='escada_ergometrica_m.mp4'}
  @{Old='face_pull_corda.mp4'; New='face_pull_corda_m.mp4'}
  @{Old='flexao_de_bracos.mp4'; New='flexao_de_bracos_m.mp4'}
  @{Old='flexao_de_bracos (2).mp4'; New='flexao_de_bracos_f.mp4'}
  @{Old='flexao_de_bracos_ajoelhada.mp4'; New='flexao_de_bracos_ajoelhada_m.mp4'}
  @{Old='flexao_de_bracos_com_joelhos.mp4'; New='flexao_de_bracos_com_joelhos_m.mp4'}
  @{Old='flexao_de_bracos_declinada.mp4'; New='flexao_de_bracos_declinada_m.mp4'}
  @{Old='flexao_de_bracos_diamante.mp4'; New='flexao_de_bracos_diamante_m.mp4'}
  @{Old='flexao_de_bracos_inclinada.mp4'; New='flexao_de_bracos_inclinada_m.mp4'}
  @{Old='flexao_de_bracos_inclinada (2).mp4'; New='flexao_de_bracos_inclinada_f.mp4'}
  @{Old='flexao_de_bracos_na_parede.mp4'; New='flexao_de_bracos_na_parede_m.mp4'}
  @{Old='flexao_de_bracos_na_parede (2).mp4'; New='flexao_de_bracos_na_parede_f.mp4'}
  @{Old='flexao_de_bracos_solo.mp4'; New='flexao_de_bracos_solo_m.mp4'}
  @{Old='flexao_de_bracos_solo (2).mp4'; New='flexao_de_bracos_solo_f.mp4'}
  @{Old='flexao_de_bracos_solo (3).mp4'; New='flexao_de_bracos_solo_f2.mp4'}
  @{Old='flexao_de_bracos_tradicional.mp4'; New='flexao_de_bracos_tradicional_m.mp4'}
  @{Old='flexão_de_pernas_maquina_sentado.mp4'; New='flexao_de_pernas_maquina_sentado_m.mp4'}
  @{Old='flexao_diamante.mp4'; New='flexao_diamante_m.mp4'}
  @{Old='flexao_pike.mp4'; New='flexao_pike_m.mp4'}
  @{Old='kettlebell_swing.mp4'; New='kettlebell_swing_m.mp4'}
  @{Old='leg_press_45.mp4'; New='leg_press_45_m.mp4'}
  @{Old='leg_press_45_horizontal.mp4'; New='leg_press_45_horizontal_m.mp4'}
  @{Old='leg_press_45_inclinado.mp4'; New='leg_press_45_inclinado_m.mp4'}
  @{Old='leg_press_maquina.mp4'; New='leg_press_maquina_f.mp4'}
  @{Old='mesa_flexora.mp4'; New='mesa_flexora_f.mp4'}
  @{Old='panturrilha_em_pe.mp4'; New='panturrilha_em_pe_m.mp4'}
  @{Old='peck_deck.mp4'; New='peck_deck_m.mp4'}
  @{Old='polichinelo.mp4'; New='polichinelo_m.mp4'}
  @{Old='polichinelo_frontal.mp4'; New='polichinelo_frontal_f.mp4'}
  @{Old='polichinelo_tradicional.mp4'; New='polichinelo_tradicional_f.mp4'}
  @{Old='prancha_abdominal.mp4'; New='prancha_abdominal_m.mp4'}
  @{Old='prancha_abdominal (2).mp4'; New='prancha_abdominal_f.mp4'}
  @{Old='pull_down_corda.mp4'; New='pull_down_corda_m.mp4'}
  @{Old='puxada_frente_polia_alta.mp4'; New='puxada_frente_polia_alta_m.mp4'}
  @{Old='puxada_frente_polia_alta (2).mp4'; New='puxada_frente_polia_alta_f.mp4'}
  @{Old='puxada_unilateral_polia.mp4'; New='puxada_unilateral_polia_m.mp4'}
  @{Old='puxada_unilateral_polia (2).mp4'; New='puxada_unilateral_polia_f.mp4'}
  @{Old='remada_baixa_polia.mp4'; New='remada_baixa_polia_m.mp4'}
  @{Old='remada_baixa_polia (2).mp4'; New='remada_baixa_polia_f.mp4'}
  @{Old='remada_curvada_barra.mp4'; New='remada_curvada_barra_m.mp4'}
  @{Old='remada_curvada_barra (2).mp4'; New='remada_curvada_barra_f.mp4'}
  @{Old='remada_curvada_halteres.mp4'; New='remada_curvada_halteres_m.mp4'}
  @{Old='remada_curvada_halteres_pronada.mp4'; New='remada_curvada_halteres_pronada_m.mp4'}
  @{Old='remada_maquina_remo.mp4'; New='remada_maquina_remo_m.mp4'}
  @{Old='remada_maquina_sentado.mp4'; New='remada_maquina_sentado_m.mp4'}
  @{Old='remada_sentada_maquina.mp4'; New='remada_sentada_maquina_m.mp4'}
  @{Old='remada_unilateral_com_haltere.mp4'; New='remada_unilateral_com_haltere_m.mp4'}
  @{Old='remada_unilateral_halteres.mp4'; New='remada_unilateral_halteres_m.mp4'}
  @{Old='rosca_biceps_corda_polia_baixa.mp4'; New='rosca_biceps_corda_polia_baixa_m.mp4'}
  @{Old='rosca_bíceps_na_polia_baixa.mp4'; New='rosca_biceps_na_polia_baixa_m.mp4'}
  @{Old='rosca_concentrada_halteres.mp4'; New='rosca_concentrada_halteres_m.mp4'}
  @{Old='rosca_concentrada_halteres (2).mp4'; New='rosca_concentrada_halteres_f.mp4'}
  @{Old='rosca_direta_barra.mp4'; New='rosca_direta_barra_m.mp4'}
  @{Old='rosca_direta_halteres.mp4'; New='rosca_direta_halteres_m.mp4'}
  @{Old='rosca_martelo_alternada.mp4'; New='rosca_martelo_alternada_m.mp4'}
  @{Old='rosca_martelo_alternada_halteres.mp4'; New='rosca_martelo_alternada_halteres_m.mp4'}
  @{Old='rosca_martelo_halteres.mp4'; New='rosca_martelo_halteres_m.mp4'}
  @{Old='rosca_martelo_halteres (2).mp4'; New='rosca_martelo_halteres_f.mp4'}
  @{Old='rosca_martelo_halteres (3).mp4'; New='rosca_martelo_halteres_f2.mp4'}
  @{Old='stiff_com_barra.mp4'; New='stiff_com_barra_m.mp4'}
  @{Old='stiff_com_halteres.mp4'; New='stiff_com_halteres_m.mp4'}
  @{Old='stiff_deadlift_halteres.mp4'; New='stiff_deadlift_halteres_m.mp4'}
  @{Old='stiff_deadlift_halteres (2).mp4'; New='stiff_deadlift_halteres_f.mp4'}
  @{Old='supino_articulado_maquina.mp4'; New='supino_articulado_maquina_m.mp4'}
  @{Old='supino_barra_reto.mp4'; New='supino_barra_reto_m.mp4'}
  @{Old='supino_fechado_com_halteres.mp4'; New='supino_fechado_com_halteres_m.mp4'}
  @{Old='supino_fechado_halteres.mp4'; New='supino_fechado_halteres_m.mp4'}
  @{Old='supino_halteres_reto.mp4'; New='supino_halteres_reto_m.mp4'}
  @{Old='supino_inclinado_articulado_maquina.mp4'; New='supino_inclinado_articulado_maquina_m.mp4'}
  @{Old='supino_inclinado_barra.mp4'; New='supino_inclinado_barra_m.mp4'}
  @{Old='supino_inclinado_com_halteres.mp4'; New='supino_inclinado_com_halteres_m.mp4'}
  @{Old='supino_inclinado_halteres.mp4'; New='supino_inclinado_halteres_m.mp4'}
  @{Old='supino_inclinado_halteres (2).mp4'; New='supino_inclinado_halteres_f.mp4'}
  @{Old='supino_maquina.mp4'; New='supino_maquina_m.mp4'}
  @{Old='supino_reto_barra.mp4'; New='supino_reto_barra_m.mp4'}
  @{Old='supino_reto_halteres.mp4'; New='supino_reto_halteres_m.mp4'}
  @{Old='supino_reto_halteres (2).mp4'; New='supino_reto_halteres_f.mp4'}
  @{Old='triceps_banco.mp4'; New='triceps_banco_m.mp4'}
  @{Old='triceps_banco (2).mp4'; New='triceps_banco_f.mp4'}
  @{Old='triceps_banco (3).mp4'; New='triceps_banco_f2.mp4'}
  @{Old='triceps_coice_com_halteres.mp4'; New='triceps_coice_com_halteres_m.mp4'}
  @{Old='triceps_coice_halteres.mp4'; New='triceps_coice_halteres_m.mp4'}
  @{Old='triceps_corda.mp4'; New='triceps_corda_m.mp4'}
  @{Old='triceps_corda_costas_polia_baixa.mp4'; New='triceps_corda_costas_polia_baixa_m.mp4'}
  @{Old='triceps_corda_polia.mp4'; New='triceps_corda_polia_m.mp4'}
  @{Old='triceps_corda_polia_alta.mp4'; New='triceps_corda_polia_alta_m.mp4'}
  @{Old='triceps_frances_barra_supino.mp4'; New='triceps_frances_barra_supino_m.mp4'}
  @{Old='triceps_frances_haltere.mp4'; New='triceps_frances_haltere_m.mp4'}
  @{Old='triceps_frances_halteres_solo.mp4'; New='triceps_frances_halteres_solo_m.mp4'}
  @{Old='triceps_frances_sentado_com_halteres.mp4'; New='triceps_frances_sentado_com_halteres_m.mp4'}
  @{Old='triceps_frances_unilateral_halteres.mp4'; New='triceps_frances_unilateral_halteres_m.mp4'}
  @{Old='triceps_kickback_haltere.mp4'; New='triceps_kickback_haltere_m.mp4'}
  @{Old='triceps_mergulho_solo.mp4'; New='triceps_mergulho_solo_m.mp4'}
  @{Old='triceps_pulley_corda.mp4'; New='triceps_pulley_corda_m.mp4'}
  @{Old='triceps_pulley_pronada.mp4'; New='triceps_pulley_pronada_m.mp4'}
  @{Old='triceps_pulley_v.mp4'; New='triceps_pulley_v_m.mp4'}
  @{Old='triceps_solo.mp4'; New='triceps_solo_m.mp4'}
  @{Old='triceps_testa_halteres.mp4'; New='triceps_testa_halteres_m.mp4'}
  @{Old='triceps_testa_halteres (2).mp4'; New='triceps_testa_halteres_f.mp4'}
  @{Old='voador_maquina.mp4'; New='voador_maquina_m.mp4'}
)
foreach ($p in $pairs) {
  $oldPath = Join-Path $base $p.Old
  if (Test-Path -LiteralPath $oldPath) { Rename-Item -LiteralPath $oldPath -NewName $p.New }
}
