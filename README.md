# SeisSol Workflows

This repository contains a list of [Github Action workflows][gha] 
showcasing how to execute earthquake simulations using the 
[SeisSol][seissol] framework. SeisSol is a software package for 
simulating wave propagation and dynamic rupture based on the arbitrary 
high-order accurate derivative discontinuous Galerkin method 
(ADER-DG). For more on SeisSol, visit the [official website][seissol].

This repository contains multiple workflows in the `workflows/` folder 
that showcase how to execute:

 1. A SCEC benchmark ([`workflows/tpv33`](./workflows/tpv33)).
 2. The [SCC18 challenge workflow][scc18] 
    ([`workflows/scc18`](./workflows/scc18)).
 3. The SCC18 challenge workflow on environments where build-time 
    dependencies are installed externally (e.g. by system 
    administrators). 
    ([`workflows/scc18-containerless`](./workflows/scc18-containerless)).

The first two workflows run in a container runtime ([Docker][docker], 
[Singularity][singularity], etc.), while the third runs directly on 
the host. These workflows can be executed with the [Popper CLI 
tool][popper]. For example:

```bash
git clone --recursive https://github.com/popperized/seissol-workflows

cd seissol-workflows/workflows/tpv33

popper run
```

For more information on each workflow, take a look at the `README` 
file in each subfolder.

[seissol]: http://www.seissol.org
[scc18]: http://www.studentclustercompetition.us/2018/applications.html
[gha]: https://developer.github.com/actions/managing-workflows/workflow-configuration-options/#example-workflow
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity
[docker]: https://get.docker.com
