```vega-lite
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "Shows the degradation of success rate over iterative cycles, comparing a known task (fizzbuzz) to a novel task (vowels).",
  "title": {
    "text": "Figure 2: Iterative Stability Degradation Curves",
    "subtitle": "Success rate by iteration cycle for known vs. novel tasks (n=30)",
    "anchor": "start"
  },
  "width": 600,
  "data": {
    "values": [
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 1,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 2,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 3,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 4,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 5,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 6,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 7,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 8,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 9,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 10,
        "survival_rate": 100.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 60.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 46.666666666666664
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 30.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 20.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 20.0
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 16.666666666666664
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 6.666666666666667
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 3.3333333333333335
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 3.3333333333333335
      },
      {
        "model": "falcon3-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 3.3333333333333335
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 1,
        "survival_rate": 20.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 2,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 3,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 4,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 5,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 6,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "falcon3-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 10,
        "survival_rate": 0.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 1,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 2,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 3,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 4,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 5,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 6,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 7,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 8,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 9,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 10,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 100.0
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 96.66666666666667
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 86.66666666666667
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 76.66666666666667
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 66.66666666666666
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 56.666666666666664
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 53.333333333333336
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 50.0
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 50.0
      },
      {
        "model": "gemma3-4b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 50.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 1,
        "survival_rate": 36.666666666666664
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 2,
        "survival_rate": 10.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 3,
        "survival_rate": 3.3333333333333335
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 4,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 5,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 6,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 10,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 90.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 86.66666666666667
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 83.33333333333334
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 70.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 66.66666666666666
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 60.0
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 53.333333333333336
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 53.333333333333336
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 53.333333333333336
      },
      {
        "model": "llama3-8b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 46.666666666666664
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 1,
        "survival_rate": 26.666666666666668
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 2,
        "survival_rate": 6.666666666666667
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 3,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 4,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 5,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 6,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 10,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 53.333333333333336
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 20.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 6.666666666666667
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "llama3-8b",
        "task": "separate_vowels_and_consonants",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 1,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 2,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 3,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 4,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 5,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 6,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 7,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 8,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 9,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "en",
        "cycle": 10,
        "survival_rate": 100.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 1,
        "survival_rate": 66.66666666666666
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 2,
        "survival_rate": 36.666666666666664
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 3,
        "survival_rate": 33.33333333333333
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 4,
        "survival_rate": 26.666666666666668
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 5,
        "survival_rate": 20.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 6,
        "survival_rate": 6.666666666666667
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "fizzbuzz",
        "language": "ja",
        "cycle": 10,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 1,
        "survival_rate": 26.666666666666668
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 2,
        "survival_rate": 13.333333333333334
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 3,
        "survival_rate": 6.666666666666667
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 4,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 5,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 6,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 7,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 8,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 9,
        "survival_rate": 0.0
      },
      {
        "model": "llama3.2-3b",
        "task": "separate_vowels_and_consonants",
        "language": "en",
        "cycle": 10,
        "survival_rate": 0.0
      }
    ]
  },
  "transform": [
    {
      "filter": "(datum.model == 'gemma3-4b' && datum.language == 'ja') || ((datum.model == 'falcon3-3b' || datum.model == 'llama3.2-3b' || datum.model == 'llama3-8b') && datum.language == 'en')"
    }
  ],
  "facet": {
    "row": {
      "field": "model",
      "type": "nominal",
      "title": "Model",
      "header": {
        "labelFontSize": 12,
        "titleFontSize": 14
      }
    }
  },
  "spec": {
    "width": 600,
    "height": 180,
    "mark": {
      "type": "line",
      "point": true
    },
    "encoding": {
      "x": {
        "field": "cycle",
        "type": "quantitative",
        "title": "Iteration Cycle",
        "axis": {
          "grid": false,
          "tickCount": 10
        }
      },
      "y": {
        "field": "survival_rate",
        "type": "quantitative",
        "title": "Success Rate (%)",
        "scale": {
          "domain": [
            0,
            100
          ]
        },
        "axis": {
          "grid": true
        }
      },
      "color": {
        "field": "task",
        "type": "nominal",
        "title": "Task Type",
        "scale": {
          "domain": [
            "fizzbuzz",
            "separate_vowels_and_consonants"
          ],
          "range": [
            "#1f77b4",
            "#ff7f0e"
          ]
        }
      }
    }
  },
  "resolve": {
    "scale": {
      "color": "independent"
    }
  },
  "config": {
    "axis": {
      "labelFontSize": 11,
      "titleFontSize": 13
    },
    "legend": {
      "orient": "top"
    }
  }
}
```
