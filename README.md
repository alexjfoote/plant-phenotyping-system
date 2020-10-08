# Plant Phenotyping System

Please refer the Technical Report for a detailed report on the project and the developed software.

## Aim
This project aims to develop highly automated plant phenotyping software. The software will
take as input multiple depth images from several different viewpoints of plant, and construct a
three-dimensional (3D) model of the plant. It will then extract desired holistic phenotypes from
the plant model, and produce graphs of the change in the traits of a plant over the course of
several timepoints.

## Motivations
In 2017, 10.8% of the global population, corresponding to 810 million people, were undernourished [1], and undernutrition is estimated be responsible for close to half of all child deaths annually [2]. Decreasing the number of undernourished people and improving global food security
is a major challenge, made even more difficult by a growing global population that is expected
to reach approximately 10 billion by 2050 [3]. Additionally, the majority of this growth is expected to come from regions with the greatest food insecurity, with the population of Africa -
where 19.9% of their population are undernourished, the highest proportion of any region [1]
- forecast to double in the same timeframe [4]. This population growth, combined with the
increased demand for biofuel, means that the demand for cereal crops, which constitute roughly
half of the daily calories of individuals in developing countries [5], is predicted to increase by
approximately 50% by 2050 [6].
Climate change also presents major challenges regarding food production, with changes
in temperature, rainfall, and other factors, as well as an increase in the frequency of extreme
weather events negatively affecting crop yield [7]. Climate change will have a greater impact
on areas of low latitude, that correspond to developing regions with poor food security, such as
sub-Saharan Africa [8].
To meet the demands of increased cereal production and reduce the prevalence of undernutrition, plant breeds that produce greater yields are required. These plants will also need to be
able to survive in the increasingly stressful conditions that climate change will create. To identify
and select breeds with these desirable characteristics, the ability to measure the response of the
physical and physiological traits of a plant to a particular environment is crucial. Historically,
these traits have been measured by hand, a slow and labour intensive process that often becomes
a bottleneck in plant breeding [9]. Additionally, some measurements could only be taken at a
single timepoint, as they required the destruction of the plant. These problems with manual
plant phenotyping have motivated research into the development of automated plant phenotyping systems, which can extract useful measurements at high-throughputs, non-destructively, so
1
the phenotype can be measured across several timepoints.

