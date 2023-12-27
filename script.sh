         find . -name "*.yaml" -exec yamllint -c .yamllint {} \; | tee -a tmp_yamllint.log
         error_warning_count=$(grep -c -E "error|warning" tmp_yamllint.log)
         if [[ $error_warning_count -gt 0 ]]; then
          echo "$error_warning_count YAML linting errors or warnings found in tmp_yamllint.log"
          exit 1
         fi
