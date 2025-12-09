# Manuscript Section Writer

You are drafting a section for a statistical methodology manuscript.

## Task

Write the **$ARGUMENTS** section for the current manuscript project.

If no section specified, ask which section to write.

## Available Sections

1. **introduction** - Problem, existing work, gap, contribution
2. **methods** - Notation, identification, estimation, inference
3. **simulation** - Design, results, interpretation
4. **application** - Data, analysis, results
5. **discussion** - Summary, implications, limitations, future work

## Section Templates

### Introduction
```latex
\section{Introduction}

% Paragraph 1: Problem and motivation
[Scientific problem] is fundamental to [field]. Understanding [specific aspect]
is crucial for [practical impact].

% Paragraph 2: Existing approaches
Several methods have been proposed for [problem]. \citet{Author2020} developed
[method 1], while \citet{Author2021} proposed [method 2].

% Paragraph 3: Gap
However, existing methods [limitation]. Specifically, [gap description].

% Paragraph 4: Our contribution
We propose [method name], which addresses [gap] by [key innovation].
Our approach [key properties: robust, efficient, etc.].

% Paragraph 5: Results preview
Theoretically, we establish [main results]. Simulations demonstrate [findings].
We apply our method to [application] and find [key results].

% Paragraph 6: Organization
The remainder of this paper is organized as follows. Section~\ref{sec:methods}
develops [methods]. Section~\ref{sec:simulation} presents simulation studies...
```

### Methods
```latex
\section{Methods}
\label{sec:methods}

\subsection{Notation and Setup}
Let $O = (Y, A, M, X)$ denote the observed data where...
We assume $n$ i.i.d. copies from distribution $P$.

\subsection{Target Estimand}
Our target estimand is [precise definition]:
\[
\psi = [formula]
\]

\subsection{Identification}
\begin{assumption}[Name]
\label{A1}
[Statement]
\end{assumption}
...

\begin{theorem}[Identification]
Under Assumptions \ref{A1}--\ref{An}, $\psi$ is identified by [formula].
\end{theorem}

\subsection{Estimation}
Based on the identification result, we propose:
\[
\hat{\psi}_n = [estimator]
\]

\subsection{Asymptotic Properties}
\begin{theorem}[Asymptotic Normality]
Under Conditions \ref{C1}--\ref{Cn},
$\sqrt{n}(\hat{\psi}_n - \psi_0) \xrightarrow{d} N(0, V)$.
\end{theorem}
```

### Simulation
```latex
\section{Simulation Study}
\label{sec:simulation}

\subsection{Design}
We evaluate finite-sample performance via Monte Carlo simulation.

\paragraph{Data Generation.}
[DGP description with formulas]

\paragraph{Parameter Grid.}
\begin{itemize}
\item Sample size: $n \in \{200, 500, 1000, 2000\}$
\item Effect size: [values]
\item [Other factors]
\end{itemize}

\paragraph{Methods Compared.}
\begin{enumerate}
\item Proposed estimator
\item [Competitor 1]
\item [Competitor 2]
\end{enumerate}

\paragraph{Performance Metrics.}
Bias, empirical SE, average SE, 95\% CI coverage, MSE.
Each scenario: 1000 replications.

\subsection{Results}
[Tables and interpretation]
```

## Writing Guidelines

### Style
- Use VanderWeele notation for causal/mediation quantities
- Define all symbols before use
- Be precise but accessible
- Active voice where appropriate

### LaTeX Conventions
- Use `\citet{}` and `\citep{}` for citations
- Use `align` environment for multi-line equations
- Label all equations, theorems, assumptions
- Use `\ref{}` for cross-references

### Journal-Specific (JASA)
- ~25-30 pages main text
- Proofs in supplementary materials
- Structured abstract optional

## Output Format

Return LaTeX code for the section, ready to paste into the manuscript.

Include comments indicating:
- What citations are needed
- What results should be referenced
- What figures/tables should be included

## Skills to Apply
- methods-paper-writer
- proof-architect
- identification-theory
- asymptotic-theory
