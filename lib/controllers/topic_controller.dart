import 'package:get/get.dart';
import '../models/topic_model.dart';

class TopicController extends GetxController {
  final topics = <TopicModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    topics.addAll([
      TopicModel(
        titleKey: 'mechanics',
        description: 'mechanics_desc',
        keyConcepts: [
          'key_concepts_newton_laws',
          'key_concepts_kinematics',
          'key_concepts_dynamics',
        ],
        formulas: [
          'F = ma',
          'v = u + at',
          's = ut + ½at²',
        ],
        funFact: 'mechanics_fact',
        questions: [
          Question(
            questionKey: 'mechanics_question_1',
            options: [
              'mechanics_option_1_1',
              'mechanics_option_1_2',
              'mechanics_option_1_3',
            ],
            correctAnswer: 'mechanics_option_1_1',
          ),
          Question(
            questionKey: 'mechanics_question_2',
            options: null,
            correctAnswer: 'mechanics_answer_2',
          ),
          Question(
            questionKey: 'mechanics_question_3',
            options: [
              'mechanics_option_3_1',
              'mechanics_option_3_2',
              'mechanics_option_3_3',
            ],
            correctAnswer: 'mechanics_option_3_2',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'thermodynamics',
        description: 'thermodynamics_desc',
        keyConcepts: [
          'key_concepts_heat_transfer',
          'key_concepts_thermodynamic_laws',
          'key_concepts_entropy',
        ],
        formulas: [
          'Q = mcΔT',
          'PV = nRT',
          'ΔS = Q/T',
        ],
        funFact: 'thermodynamics_fact',
        questions: [
          Question(
            questionKey: 'thermodynamics_question_1',
            options: [
              'thermodynamics_option_1_1',
              'thermodynamics_option_1_2',
              'thermodynamics_option_1_3',
            ],
            correctAnswer: 'thermodynamics_option_1_2',
          ),
          Question(
            questionKey: 'thermodynamics_question_2',
            options: null,
            correctAnswer: 'thermodynamics_answer_2',
          ),
          Question(
            questionKey: 'thermodynamics_question_3',
            options: [
              'thermodynamics_option_3_1',
              'thermodynamics_option_3_2',
              'thermodynamics_option_3_3',
            ],
            correctAnswer: 'thermodynamics_option_3_1',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'electromagnetism',
        description: 'electromagnetism_desc',
        keyConcepts: [
          'key_concepts_electric_fields',
          'key_concepts_magnetic_fields',
          'key_concepts_maxwell',
        ],
        formulas: [
          'F = qE',
          'V = IR',
          'B = μ₀I/(2πr)',
        ],
        funFact: 'electromagnetism_fact',
        questions: [
          Question(
            questionKey: 'electromagnetism_question_1',
            options: [
              'electromagnetism_option_1_1',
              'electromagnetism_option_1_2',
              'electromagnetism_option_1_3',
            ],
            correctAnswer: 'electromagnetism_option_1_3',
          ),
          Question(
            questionKey: 'electromagnetism_question_2',
            options: null,
            correctAnswer: 'electromagnetism_answer_2',
          ),
          Question(
            questionKey: 'electromagnetism_question_3',
            options: [
              'electromagnetism_option_3_1',
              'electromagnetism_option_3_2',
              'electromagnetism_option_3_3',
            ],
            correctAnswer: 'electromagnetism_option_3_2',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'optics',
        description: 'optics_desc',
        keyConcepts: [
          'key_concepts_reflection',
          'key_concepts_refraction',
          'key_concepts_lenses',
        ],
        formulas: [
          'n₁sinθ₁ = n₂sinθ₂',
          '1/f = 1/u + 1/v',
          'm = hᵢ/h₀',
        ],
        funFact: 'optics_fact',
        questions: [
          Question(
            questionKey: 'optics_question_1',
            options: [
              'optics_option_1_1',
              'optics_option_1_2',
              'optics_option_1_3',
            ],
            correctAnswer: 'optics_option_1_1',
          ),
          Question(
            questionKey: 'optics_question_2',
            options: null,
            correctAnswer: 'optics_answer_2',
          ),
          Question(
            questionKey: 'optics_question_3',
            options: [
              'optics_option_3_1',
              'optics_option_3_2',
              'optics_option_3_3',
            ],
            correctAnswer: 'optics_option_3_3',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'quantum_physics',
        description: 'quantum_physics_desc',
        keyConcepts: [
          'key_concepts_wave_particle',
          'key_concepts_uncertainty',
          'key_concepts_quantum_states',
        ],
        formulas: [
          'E = hν',
          'ΔxΔp ≥ ħ/2',
          'ψ(x,t) = Ae^(i(kx-ωt))',
        ],
        funFact: 'quantum_physics_fact',
        questions: [
          Question(
            questionKey: 'quantum_physics_question_1',
            options: [
              'quantum_physics_option_1_1',
              'quantum_physics_option_1_2',
              'quantum_physics_option_1_3',
            ],
            correctAnswer: 'quantum_physics_option_1_2',
          ),
          Question(
            questionKey: 'quantum_physics_question_2',
            options: null,
            correctAnswer: 'quantum_physics_answer_2',
          ),
          Question(
            questionKey: 'quantum_physics_question_3',
            options: [
              'quantum_physics_option_3_1',
              'quantum_physics_option_3_2',
              'quantum_physics_option_3_3',
            ],
            correctAnswer: 'quantum_physics_option_3_1',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'nuclear_physics',
        description: 'nuclear_physics_desc',
        keyConcepts: [
          'key_concepts_radioactivity',
          'key_concepts_nuclear_reactions',
          'key_concepts_fission_fusion',
        ],
        formulas: [
          'E = mc²',
          'N = N₀e^(-λt)',
          'Q = (mᵢ - mₒ)c²',
        ],
        funFact: 'nuclear_physics_fact',
        questions: [
          Question(
            questionKey: 'nuclear_physics_question_1',
            options: [
              'nuclear_physics_option_1_1',
              'nuclear_physics_option_1_2',
              'nuclear_physics_option_1_3',
            ],
            correctAnswer: 'nuclear_physics_option_1_3',
          ),
          Question(
            questionKey: 'nuclear_physics_question_2',
            options: null,
            correctAnswer: 'nuclear_physics_answer_2',
          ),
          Question(
            questionKey: 'nuclear_physics_question_3',
            options: [
              'nuclear_physics_option_3_1',
              'nuclear_physics_option_3_2',
              'nuclear_physics_option_3_3',
            ],
            correctAnswer: 'nuclear_physics_option_3_2',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'astrophysics',
        description: 'astrophysics_desc',
        keyConcepts: [
          'key_concepts_gravitation',
          'key_concepts_stellar_evolution',
          'key_concepts_cosmology',
        ],
        formulas: [
          'F = GMm/r²',
          'L = 4πR²σT⁴',
          'H₀ = v/d',
        ],
        funFact: 'astrophysics_fact',
        questions: [
          Question(
            questionKey: 'astrophysics_question_1',
            options: [
              'astrophysics_option_1_1',
              'astrophysics_option_1_2',
              'astrophysics_option_1_3',
            ],
            correctAnswer: 'astrophysics_option_1_1',
          ),
          Question(
            questionKey: 'astrophysics_question_2',
            options: null,
            correctAnswer: 'astrophysics_answer_2',
          ),
          Question(
            questionKey: 'astrophysics_question_3',
            options: [
              'astrophysics_option_3_1',
              'astrophysics_option_3_2',
              'astrophysics_option_3_3',
            ],
            correctAnswer: 'astrophysics_option_3_3',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'acoustics',
        description: 'acoustics_desc',
        keyConcepts: [
          'key_concepts_sound_waves',
          'key_concepts_doppler',
          'key_concepts_resonance',
        ],
        formulas: [
          'v = fλ',
          'f\' = f(v ± v₀)/(v ± vₛ)',
          'I = P/(4πr²)',
        ],
        funFact: 'acoustics_fact',
        questions: [
          Question(
            questionKey: 'acoustics_question_1',
            options: [
              'acoustics_option_1_1',
              'acoustics_option_1_2',
              'acoustics_option_1_3',
            ],
            correctAnswer: 'acoustics_option_1_2',
          ),
          Question(
            questionKey: 'acoustics_question_2',
            options: null,
            correctAnswer: 'acoustics_answer_2',
          ),
          Question(
            questionKey: 'acoustics_question_3',
            options: [
              'acoustics_option_3_1',
              'acoustics_option_3_2',
              'acoustics_option_3_3',
            ],
            correctAnswer: 'acoustics_option_3_1',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'mechanical_waves',
        description: 'mechanical_waves_desc',
        keyConcepts: [
          'key_concepts_wave_properties',
          'key_concepts_interference',
          'key_concepts_standing_waves',
        ],
        formulas: [
          'v = √(T/μ)',
          'f = n(v/2L)',
          'λ = v/f',
        ],
        funFact: 'mechanical_waves_fact',
        questions: [
          Question(
            questionKey: 'mechanical_waves_question_1',
            options: [
              'mechanical_waves_option_1_1',
              'mechanical_waves_option_1_2',
              'mechanical_waves_option_1_3',
            ],
            correctAnswer: 'mechanical_waves_option_1_3',
          ),
          Question(
            questionKey: 'mechanical_waves_question_2',
            options: null,
            correctAnswer: 'mechanical_waves_answer_2',
          ),
          Question(
            questionKey: 'mechanical_waves_question_3',
            options: [
              'mechanical_waves_option_3_1',
              'mechanical_waves_option_3_2',
              'mechanical_waves_option_3_3',
            ],
            correctAnswer: 'mechanical_waves_option_3_2',
          ),
        ],
      ),
      TopicModel(
        titleKey: 'relativistic_physics',
        description: 'relativistic_physics_desc',
        keyConcepts: [
          'key_concepts_special_relativity',
          'key_concepts_time_dilation',
          'key_concepts_mass_energy',
        ],
        formulas: [
          'E = mc²',
          't = t₀/√(1 - v²/c²)',
          'L = L₀√(1 - v²/c²)',
        ],
        funFact: 'relativistic_physics_fact',
        questions: [
          Question(
            questionKey: 'relativistic_physics_question_1',
            options: [
              'relativistic_physics_option_1_1',
              'relativistic_physics_option_1_2',
              'relativistic_physics_option_1_3',
            ],
            correctAnswer: 'relativistic_physics_option_1_1',
          ),
          Question(
            questionKey: 'relativistic_physics_question_2',
            options: null,
            correctAnswer: 'relativistic_physics_answer_2',
          ),
          Question(
            questionKey: 'relativistic_physics_question_3',
            options: [
              'relativistic_physics_option_3_1',
              'relativistic_physics_option_3_2',
              'relativistic_physics_option_3_3',
            ],
            correctAnswer: 'relativistic_physics_option_3_3',
          ),
        ],
      ),
    ]);
  }
}