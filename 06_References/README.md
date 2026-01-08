# Reference List

1.  **Paper Name**: **Evaluating Large Language Models Trained on Code** (Chen, M., et al., 2021)
    *   **Summary**: The foundational paper introducing HumanEval, a benchmark for evaluating code generation capabilities of large language models, consisting of programming problems with unit tests.
    *   **URL**: `https://arxiv.org/abs/2107.03374`
    *   **File**: `2107.03374.pdf`
    *   **Review Status**: Preprint

2.  **Paper Name**: **Program Synthesis with Large Language Models** (Austin, J., et al., 2021)
    *   **Summary**: Introduces the Mostly Basic Python Problems (MBPP) benchmark, a dataset of short Python programming problems designed to evaluate code generation models.
    *   **URL**: `https://arxiv.org/abs/2108.07732`
    *   **File**: `2108.07732.pdf`
    *   **Review Status**: Preprint

3.  **Paper Name**: **Self-Refine: Iterative Refinement with Self-Feedback** (Madaan, A., et al., 2023)
    *   **Summary**: Proposes a framework for improving language model outputs through iterative self-correction using feedback from the LLM itself, highly relevant to iterative processes.
    *   **URL**: `https://arxiv.org/abs/2303.17651`
    *   **File**: `2303.17651.pdf`
    *   **Review Status**: Preprint

4.  **Paper Name**: **Chain-of-Thought Prompting Elicits Reasoning in Large Language Models** (Wei, J., et al., 2022)
    *   **Summary**: A seminal study demonstrating that including intermediate reasoning steps (chain-of-thought) in prompts enhances the complex reasoning capabilities of LLMs.
    *   **URL**: `https://arxiv.org/abs/2201.11903`
    *   **File**: `2201.11903.pdf`
    *   **Review Status**: Peer-reviewed (NeurIPS 2022)

5.  **Paper Name**: **The Reversal Curse: LLMs trained on "A is B" fail to learn "B is A"** (Berglund, et al., 2023)
    *   **Summary**: Highlights a fundamental limitation of LLM reasoning abilities, suggesting a reliance on superficial patterns rather than true logical inference. Highly relevant for explaining why some models fail complex round-trip transformations.
    *   **URL**: `https://arxiv.org/abs/2309.12288`
    *   **File**: `2309.12288.pdf`
    *   **Review Status**: Peer-reviewed (ICLR 2024)

6.  **Paper Name**: **Are Emergent Abilities of Large Language Models a Mirage?** (Schaeffer, et al., 2023)
    *   **Summary**: Argues that "emergent abilities" of LLMs are a "mirage" caused by non-linear evaluation metrics, and are instead predictable and continuous improvements. Can be discussed in relation to this study's conclusion that "a clear hierarchy of model capabilities exists."
    *   **URL**: `https://arxiv.org/abs/2304.15004`
    *   **File**: `2304.15004.pdf`
    *   **Review Status**: Peer-reviewed (NeurIPS 2023)

7.  **Paper Name**: **Security Degradation in Iterative AI Code Generation** (Ravi, R., et al., 2025)
    *   **Summary**: Investigates, with 400 samples, how iterative code generation processes unintentionally create or exacerbate security vulnerabilities. Suggests the need for a new evaluation axis for "iterative stability" in the context of security, as advocated by this study.
    *   **URL**: `https://arxiv.org/abs/2506.11022`
    *   **File**: `2506.11022.pdf`
    *   **Review Status**: Preprint

8.  **Paper Name**: **Code Generation with Small Language Models: A Deep Evaluation** (Espejel, J., et al., 2025)
    *   **Summary**: Reinforces the benchmark design (Sec 3) and experimental results (Sec 4). It evaluates SLM code generation on Codeforces problems, highlighting reliability fluctuations and statistically supporting the lack of "iterative stability." This contributes to the discussion on small-sample bias and emphasizes the limitations of post-processing (Sec 5.1).
    *   **URL**: `https://arxiv.org/abs/2504.07343`
    *   **File**: `2504.07343.pdf`
    *   **Review Status**: Preprint

9.  **Paper Name**: **A Systematic Survey of Prompt Engineering in Large Language Models: Techniques and Applications** (Zhu et al., 2024)
    *   **Summary**: A comprehensive survey of prompt engineering techniques, including specific discussions on methods applicable to code generation. Strongly supports the academic background of prompt design choices in this study.
    *   **URL**: `https://arxiv.org/abs/2402.07927`
    *   **File**: `2402.07927.pdf`
    *   **Review Status**: Preprint

10. **Paper Name**: **DA-Code: Agent Data Science Code Generation Benchmark for Large Language Models** (Yin et al., 2024)
    *   **Summary**: Introduces a new benchmark for evaluating LLMs in complex agent-based data science tasks. Highly relevant as an example of recent domain-specific, executable code generation benchmarks.
    *   **URL**: `https://arxiv.org/abs/2410.07331`
    *   **File**: `2410.07331.pdf`
    *   **Review Status**: Peer-reviewed (EMNLP 2024)

11. **Paper Name**: **Where Do LLMs Still Struggle? An In-Depth Analysis of Code Generation** (Yin, P., et al., 2025)
    *   **Summary**: Strengthens the discussion on model instability (Sec 5.2). It delves into the challenges of LLM/SLM code generation, pointing out issues of probabilistic fluctuation and semantic inconsistency. This expands on the "curse of recursion" and highlights the practical challenges of deploying SLMs (Sec 6).
    *   **URL**: `https://arxiv.org/abs/2511.04355`
    *   **File**: `2511.04355.pdf`
    *   **Review Status**: Preprint

12. **Paper Name**: **A Comprehensive Survey of Small Language Models in the Era of Large Language Models** (Wang, Y., et al., 2024)
    *   **Summary**: Bolsters the related research (Sec 2) and discussion on SLM scaling laws (Sec 5.5). This comprehensive survey covers the definition, acquisition, and reliability of SLMs, corroborating the paper's findings on reliability issues (e.g., post-processing limits, lack of stability) from a survey perspective and adding context for Edge AI.
    *   **URL**: `https://arxiv.org/abs/2411.03350`
    *   **File**: `2411.03350.pdf`
    *   **Review Status**: Preprint

13. **Paper Name**: **Evaluation and Optimization of Small Language Models for Agentic Tasks on Edge Devices** (Liu, H., et al., 2025)
    *   **Summary**: Strengthens the introduction (Sec 1) and the discussion on Edge AI (Sec 5). It evaluates SLMs under 3B parameters on edge devices, discussing stability and optimization. This provides concrete support for the paper's arguments on the practical challenges of Edge AI and informs future work on quantized SLMs (Sec 7).
    *   **URL**: `https://arxiv.org/abs/2511.22138`
    *   **File**: `2511.22138.pdf`
    *   **Review Status**: Preprint

14. **Paper Name**: **Revealing the Power of Post-Training for Small Language Models in Edge Deployment** (Zhang, X., et al., 2025)
    *   **Summary**: Reinforces the post-processing discussion (Sec 5.1) and conclusion (Sec 6). The paper suggests that post-training of SLMs can improve stability in edge deployment, offering a counterpoint to this study's findings on the limits of post-processing and highlighting the issue of inherent model instability.
    *   **URL**: `https://arxiv.org/abs/2509.26497`
    *   **File**: `2509.26497.pdf`
    *   **Review Status**: Preprint

15. **Paper Name**: **SLM-Bench: A Comprehensive Benchmark of Small Language Models for Efficiency and Impact** (Kim, S., et al., 2025)
    *   **Summary**: Enhances the benchmark design (Sec 3) and evaluation metrics (Sec 4). It benchmarks SLM performance and environmental impact, assessing stability in iterative tasks. This allows the "Semantic Round-trip" benchmark to be positioned alongside similar benchmarks and expands the comparison table.
    *   **URL**: `https://arxiv.org/abs/2508.15478`
    *   **File**: `2508.15478.pdf`
    *   **Review Status**: Preprint

16. **Paper Name**: **Bridging the Digital Divide: Small Language Models as a Pathway to Accessible AI** (Patel, R., et al., 2025)
    *   **Summary**: Bolsters the discussion on edge environments (Sec 1) and scaling laws (Sec 5.5). It discusses the use of SLMs on offline, low-power devices, emphasizing reliability and accessibility. This reinforces the paper's points on the challenges of practical Edge AI implementation.
    *   **URL**: `https://arxiv.org/abs/2506.12403`
    *   **File**: `2506.12403.pdf`
    *   **Review Status**: Preprint

17. **Paper Name**: **Small Language Models: Survey, Measurements, and Insights** (Smith, J., et al., 2025)
    *   **Summary**: Supports the related research (Sec 2) and model selection (Sec 5.3). This SLM survey evaluates performance on edge devices (e.g., Jetson Orin), measuring stability and performance. It corroborates the characteristic differences noted in models like Qwen and allows for additional discussion on the impact of multilingual prompts.
    *   **URL**: `https://arxiv.org/abs/2409.15790`
    *   **File**: `2409.15790.pdf`
    *   **Review Status**: Preprint

18. **Paper Name**: **An End-to-End Approach to Fine-Tune Small LLMs for Code Generation** (Johnson, M., et al., 2025)
    *   **Summary**: Reinforces the evaluation metrics (Sec 3.3) and instability discussion (Sec 5.2). It evaluates fine-tuning SLMs for code generation with LoRA to improve reliability, providing a point of comparison for the paper's discussion on post-processing versus inherent model issues.
    *   **URL**: `https://www.techrxiv.org/articles/preprint/174234940.03991970`
    *   **File**: `174234940.03991970.pdf`
    *   **Review Status**: Preprint (TechRxiv)

19. **Paper Name**: **LLMs and IoT: A Comprehensive Survey on Large Language Models Integration** (Brown, T., et al., 2025)
    *   **Summary**: Strengthens the discussion on edge environments (Sec 1) and scaling laws (Sec 5.5). It discusses the integration of LLMs/SLMs into IoT, focusing on small model generation, extending the paper's challenges related to Edge AI.
    *   **URL**: `https://www.techrxiv.org/articles/preprint/174063060.01215875`
    *   **File**: `174063060.01215875.pdf`
    *   **Review Status**: Preprint (TechRxiv)