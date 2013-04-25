iam Cookbook
============

This cookbooks provides recipes to install and configure the two IAM projects currently in flight:  IdentityIQ and RadiantOne VDS.

These should *probably* be split into separate cookbooks, at which time this will simply become a wrapper.

Requirements
------------

#### platform  
- currently only tested on `RHEL` flavored linux

#### cookbooks
- `jdk` - a home grown jdk cookbook, not fully removed
- `jboss` - installed and configures jboss, where identityiq runs
- `maven` - pulls identityiq out of our maven repo
- `mysql` - installs and configures mysql server for identityiq


Attributes
----------
TODO: List you cookbook attributes here.

#### iam::identityiq
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['iam']['identityiq']</tt></td>
    <td>Type</td>
    <td>Description</td>
    <td><tt>default</tt></td>
  </tr>
</table>

#### iam::radiantone
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['iam']['radiantone']</tt></td>
    <td>Type</td>
    <td>Description</td>
    <td><tt>default</tt></td>
  </tr>
</table>

Usage
-----
#### iam::radiantone
TODO: Write usage instructions for each cookbook.

e.g.
Just include `iam` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[iam]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: E Camden Fisher <camden.fisher@yale.edu>
